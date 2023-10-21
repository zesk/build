#!/usr/bin/env bash
#
# Run on remote systems right after code is updated to continue deployment.
#
# Note environment here is NOT THE BUILD ENVIRONMENT - it is the remote host itself
#
# The directory is currently run inside:
#
# - remoteDeploymentPath/applicationChecksum/app/
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1
errorArgument=2
start=$(($(date +%s) + 0))
set -eo pipefail
# set -x # Debugging
me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."
atticPath="$(dirname "$(pwd)")"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
    local rs
    rs=$1
    shift
    exec 1>&2
    if [ -n "$*" ]; then
        consoleError "$@"
        echo
    fi
    echo "$(consoleInfo -n "$me") $(consoleGreen -n "[ --undo | --cleanup ] [ --debug ] applicationChecksum applicationPath")"
    echo
    consoleInfo "This is run on the remote system after deployment; environment files are correct. It is run within the DEPLOYMENT"
    echo
    echo "$(consoleGreen "--debug    ")" "$(consoleInfo "Enable debugging. Defaults to BUILD_DEBUG.")"
    echo "$(consoleGreen "--undo     ")" "$(consoleInfo "Revert changes just made")"
    echo "$(consoleGreen "--cleanup  ")" "$(consoleInfo "Cleanup after success")"
    echo
    echo "$(consoleGreen "applicationChecksum   ")" "$(consoleInfo "will match APPLICATION_CHECKSUM in .env")"
    echo "$(consoleGreen "applicationPath       ")" "$(consoleInfo "path where the application is live")"
    echo
    exit "$rs"
}

usageWhich git

dotEnvConfigure

targetPackage=${BUILD_TARGET:-app.tar.gz}

currentTar="./$targetPackage"

undoFlag=
cleanupFlag=
applicationChecksum=
applicationPath=
debuggingFlag=
while [ $# -gt 0 ]; do
    case $1 in
    --debug)
        debuggingFlag=1
        ;;
    --cleanup)
        cleanupFlag=1
        ;;
    --undo)
        undoFlag=1
        ;;
    *)
        if [ -z "$applicationChecksum" ]; then
            applicationChecksum=$1
        elif [ -z "$applicationPath" ]; then
            applicationPath=$1
            if [ ! -d "$applicationPath" ]; then
                if ! mkdir -p "$applicationPath"; then
                    usage "$errorEnvironment" "Can not create $applicationPath"
                else
                    consoleWarning "Created $applicationPath"
                fi
            fi
        else
            usage "$errorArgument" "Unknown parameter $1"
        fi
        ;;
    esac
    shift
done

if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
fi
if test "$debuggingFlag"; then
    consoleWarning "Debugging is enabled"
    set -x
fi

cleanupAction() {
    #    ____ _
    #   / ___| | ___  __ _ _ __  _   _ _ __
    #  | |   | |/ _ \/ _` | '_ \| | | | '_ \
    #  | |___| |  __/ (_| | | | | |_| | |_) |
    #   \____|_|\___|\__,_|_| |_|\__,_| .__/
    #                                 |_|
    consoleInfo -n "Cleaning up ..."
    if [ -f "$currentTar" ]; then
        consoleError "Found $currentTar - LIKELY FAILURE"
        rm "$currentTar"
    fi
    if hasHook deploy-cleanup; then
        if ! runHook deploy-cleanup; then
            consoleError "Cleanup failed"
            return $errorEnvironment
        fi
    else
        consoleInfo "No deployment clean up hook"
    fi
}

undoAction() {
    local undoDeploySHA
    #   _   _           _
    #  | | | |_ __   __| | ___
    #  | | | | '_ \ / _` |/ _ \
    #  | |_| | | | | (_| | (_) |
    #   \___/|_| |_|\__,_|\___/
    #
    undoDeploySHA=$1
    shift
    consoleInfo -n "Reverting installation $undoDeploySHA ... "

    previousSHAFile="$atticPath/$undoDeploySHA.previous"
    if [ ! -f "$previousSHAFile" ]; then
        consoleError "No $previousSHAFile - no undo"
        return 0
    fi
    previousSHA=$(cat "$previousSHAFile")
    previousTar="$atticPath/$previousSHA.$targetPackage"
    if [ ! -f "$previousTar" ]; then
        consoleError "No $previousTar - no undo"
        return 0
    fi
    deployApplication "$atticPath" "$previousSHA" "$targetPackage" "$applicationPath"
    if hasHook deploy-undo; then
        if ! runHook deploy-undo "$atticPath" "$previousSHA"; then
            consoleError "deploy-undo hook failed, continuing anyway"
        fi
    else
        consoleInfo "No deployment undo hook"
    fi
    return 0
}

#   ____             _
#  |  _ \  ___ _ __ | | ___  _   _
#  | | | |/ _ \ '_ \| |/ _ \| | | |
#  | |_| |  __/ |_) | | (_) | |_| |
#  |____/ \___| .__/|_|\___/ \__, |
#             |_|            |___/
if test $undoFlag && test $cleanupFlag; then
    usage "$errorArgument" "--cleanup and --undo are mutually exclusive"
fi

start=$(beginTiming)
consoleInfo "Remote deployment finish on $(uname -n)"
echo "$(consoleLabel -n "Application Checksum:") $(consoleValue -n "$applicationChecksum")"
echo "$(consoleLabel -n "          Attic path:") $(consoleValue -n "$atticPath")"

if test $cleanupFlag; then
    cleanupAction "$applicationChecksum"
elif test $undoFlag; then
    undoDeployApplication "$atticPath" "$applicationChecksum" "$targetPackage" "$applicationPath"
else
    if [ -z "$applicationChecksum" ]; then
        usage "$errorArgument" "No argument build-sha-check passed"
    fi
    deployApplication "$atticPath" "$applicationChecksum" "$targetPackage" "$applicationPath"
fi
reportTiming "$start" "Remote deployment finished in"
