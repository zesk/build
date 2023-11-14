#!/usr/bin/env bash
#
# Run on remote systems right after code is updated to continue deployment.
#
# Note environment here is NOT THE BUILD ENVIRONMENT - it is the remote host itself
#
# The directory is currently run inside:
#
# - deployHome/applicationChecksum/app/
# - applicationHome/
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

# shellcheck source=/dev/null
. ./bin/build/tools.sh

export usageDelimiter=@
usageOptions() {
    cat <<EOF
applicationChecksum@Required. String. Should match APPLICATION_CHECKSUM in .env
deployPath@Required. String. Path where the deployments database is on remote system.
applicationPath@Required. String. Path on the remote system where the application is live.
--undo@Revert changes just made
--cleanup@Cleanup after success
--debug@Enable debugging. Defaults to BUILD_DEBUG.
EOF
}
usageDescription() {
    cat <<EOF
This is run on the remote system after deployment; environment files are correct.
It is run inside the deployment home directory in the new application folder.

Current working directory on deploy is deployHome/applicationChecksum/app.
Current working directory on cleanup is applicationHome/
Current working directory on undo is applicationHome/
EOF
}
usage() {
    usageMain "$me" "$@"
    exit $?
}

usageWhich git

dotEnvConfigure

targetPackage=${BUILD_TARGET:-app.tar.gz}

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
        elif [ -z "$deployHome" ]; then
            deployHome=$1
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
    # ____ _
    #   / ___| | ___  __ _ _ __  _   _ _ __
    #  | |   | |/ _ \/ _` | '_ \| | | | '_ \
    #  | |___| |  __/ (_| | | | | |_| | |_) |
    #   \____|_|\___|\__,_|_| |_|\__,_| .__/
    #                              |_|
    cd "$1"
    shift

    consoleInfo -n "Cleaning up ..."
    if hasHook deploy-cleanup; then
        if ! runHook deploy-cleanup; then
            consoleError "Cleanup failed"
            return $errorEnvironment
        fi
    else
        consoleInfo "No deployment clean up hook"
    fi
}

#   ____             _
#  |  _ \  ___ _ __ | | ___  _   _
#  | | | |/ _ \ '_ \| |/ _ \| | | |
#  | |_| |  __/ |_) | | (_) | |_| |
#  |____/ \___| .__/|_|\___/ \__, |
#          |_|            |___/
if test $undoFlag && test $cleanupFlag; then
    usage "$errorArgument" "--cleanup and --undo are mutually exclusive"
fi

start=$(beginTiming)
width=50
consoleNameValue $width "Host:" "$(uname -n)"
consoleNameValue $width "Deployment Path:" "$deployHome"
consoleNameValue $width "Application path:" "$applicationPath"
consoleNameValue $width "Application checksum:" "$applicationChecksum"

if test $cleanupFlag; then
    cleanupAction "$applicationPath"
elif test $undoFlag; then
    undoDeployApplication "$deployHome" "$applicationChecksum" "$targetPackage" "$applicationPath"
else
    if [ -z "$applicationChecksum" ]; then
        usage "$errorArgument" "No argument applicationChecksum passed"
    fi
    deployApplication "$deployHome" "$applicationChecksum" "$targetPackage" "$applicationPath"
fi
reportTiming "$start" "Remote deployment finished in"
