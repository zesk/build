#!/usr/bin/env bash
#
# Run on remote systems right after code is updated to continue deployment.
#
# Note environment here is NOT THE BUILD ENVIRONMENT - it is the remote host itself
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1
errArg=2
start=$(($(date +%s) + 0))
set -eo pipefail
# set -x # Debugging
me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

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
    echo "$(consoleInfo -n "$me") $(consoleGreen -n "[ --undo | --cleanup ] [ --debug ] applicationChecksum atticPath")"
    echo
    consoleInfo "This is run on the remote system after deployment; environment files are correct."
    echo
    echo "$(consoleGreen "--debug    ")" "$(consoleInfo "Enable debugging. Defaults to BUILD_DEBUG.")"
    echo "$(consoleGreen "--undo     ")" "$(consoleInfo "Revert changes just made")"
    echo "$(consoleGreen "--cleanup  ")" "$(consoleInfo "Cleanup after success")"
    echo
    echo "$(consoleGreen "applicationChecksum   ")" "$(consoleInfo "will match APPLICATION_CHECKSUM in .env")"
    echo "$(consoleGreen "atticPath  ")" "$(consoleInfo "path where backup images are stored (and pruned)")"
    echo
    exit "$rs"
}

usageWhich git

tarArgs=(--no-same-owner --no-same-permissions --no-xattrs)

dotEnvConfig

targetFileName=${BUILD_TARGET:-app.tar.gz}

currentTar="./$targetFileName"
previousCommitHashFile="./.deploy/git-commit-hash"
undoFlag=
cleanupFlag=
applicationChecksum=
atticPath=
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
        elif [ -z "$atticPath" ]; then
            atticPath=$1
            if [ ! -d "$atticPath" ]; then
                if ! mkdir -p "$atticPath"; then
                    usage "$errEnv" "Can not create $atticPath"
                else
                    consoleWarning "Created $atticPath"
                fi
            fi
        else
            usage "$errArg" "Unknown parameter $1"
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
    previousTar="$atticPath/$previousSHA.$targetFileName"
    if [ ! -f "$previousTar" ]; then
        consoleError "No $previousTar - no undo"
        return 0
    fi
    deployTarFile "$atticPath" "$previousSHA"
}

deployAction() {
    local deployTemp previousSHA applicationChecksum

    applicationChecksum=$1
    shift
    #   ____             _
    #  |  _ \  ___ _ __ | | ___  _   _
    #  | | | |/ _ \ '_ \| |/ _ \| | | |
    #  | |_| |  __/ |_) | | (_) | |_| |
    #  |____/ \___| .__/|_|\___/ \__, |
    #             |_|            |___/
    if [ ! -f "$currentTar" ]; then
        usage "$errEnv" "$currentTar is not uploaded here"
    fi

    #
    # Check the deployment file to make sure it matches what we know
    #
    # Create a deploy.123 directory, export .env and look at the value in it
    #
    deployTemp="./deploy.$$"
    if ! mkdir -p "$deployTemp"; then
        usage "$errEnv" "unable to create temp deploy directory"
    fi
    cd "$deployTemp/"
    # extract .env alone
    tar zxf "../$currentTar" "${tarArgs[@]}" ".env"
    cd ..
    set -a
    # shellcheck source=/dev/null
    . "$deployTemp/.env"
    set +a

    #
    # Check things match
    #
    if [ "$APPLICATION_CHECKSUM" != "$applicationChecksum" ]; then
        consoleRed "$deployTemp/.env"
        cat "$deployTemp/.env"
        usage "$errEnv" "Mismatch .env ($APPLICATION_CHECKSUM) != arg ($applicationChecksum)"
    fi

    rm -rf "$deployTemp"

    #
    # Maintenance on
    #
    if [ -f "$previousCommitHashFile" ]; then
        #
        # .next and .previous are created here
        #
        cp "$previousCommitHashFile" "$atticPath/$applicationChecksum.previous"
        previousCommitHash=$(cat "$previousCommitHashFile")
        if [ -f "$atticPath/$applicationChecksum.next" ]; then
            nextFileContents=$(cat "$atticPath/$applicationChecksum.next")
            if [ "$nextFileContents" != "$applicationChecksum" ]; then
                echo "$(consoleError "Mismatch next file contents: ") $(consoleError "$nextFileContents")"
                echo "$(consoleError "           Overwriting with: ") $(consoleError "$applicationChecksum")"
            fi
        fi
        echo -n "$applicationChecksum" >"$atticPath/$previousCommitHash.next"
    fi

    mv "$currentTar" "$atticPath/$applicationChecksum.$targetFileName"

    deployTarFile "$atticPath" "$applicationChecksum"
}

deployTarFile() {
    local tarBallPath shaPrefix vendorTar oldDir newDir

    tarBallPath=$1
    shift

    shaPrefix=$1
    shift

    vendorTar="$tarBallPath/$shaPrefix.$targetFileName"

    [ -f "$vendorTar" ] || usage $errEnv "Missing $vendorTar"

    consoleInfo "Unpacking $targetFileName ... "
    currentDir="$(pwd)"
    newDir="$(pwd).$$"
    mkdir -p "$newDir"
    cd "$newDir"
    tar zxf "$vendorTar" "${tarArgs[@]}"
    date >"$tarBallPath/current.date"
    cp "$tarBallPath/current.date" "$tarBallPath/$shaPrefix.date"
    cd "$currentDir"
    runHook maintenance on
    consoleInfo -n "Setting to version $shaPrefix ... "

    runHook deploy-start "$newDir"
    if hasHook deploy-move; then
        runHook deploy-move "$newDir"
    else
        oldDir="$(pwd).$$.old"
        mv "$currentDir" "$oldDir"
        mv "$newDir" "$currentDir"
        rm -rf "$oldDir"
    fi
    cd "$currentDir"

    runHook deploy-finish
    runHook maintenance off
}

if test $undoFlag && test $cleanupFlag; then
    usage "$errArg" "--cleanup and --undo are mutually exclusive"
fi
start=$(beginTiming)
if test $cleanupFlag; then
    cleanupAction "$applicationChecksum"
elif test $undoFlag; then
    undoAction "$applicationChecksum"
else
    if [ -z "$applicationChecksum" ]; then
        usage "$errArg" "No argument build-sha-check passed"
    fi
    deployAction "$applicationChecksum"
fi
reportTiming "$start" "Done."
