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
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi
top="$(pwd)"

BUILD_SETUP="$(find bin build-setup.sh)"
$BUILD_SETUP

# shellcheck source=/dev/null
. ./bin/build/tools.sh
# shellcheck source=/dev/null
. ./bin/build/tools-pipeline.sh

usage() {
    local rs
    rs=$1
    shift
    exec 1>&2
    if [ -n "$*" ]; then
        consoleError "$@"
        echo
    fi
    echo "$(consoleInfo -n "$me") $(consoleGreen -n "[ --undo | --cleanup ] build-sha-check atticPath")"
    echo
    consoleInfo "This is run on the remote system after deployment; environment files are correct."
    echo
    echo "$(consoleGreen "--undo         ")" "$(consoleInfo "Revert changes just made")"
    echo "$(consoleGreen "--cleanup      ")" "$(consoleInfo "Cleanup after success")"
    echo
    echo "$(consoleGreen "build-sha-check")" "$(consoleInfo "will match APPLICATION_GIT_SHA as well as local run command to get the git SHA")"
    echo "$(consoleGreen "atticPath      ")" "$(consoleInfo "path where backup images are stored (and pruned)")"
    echo
    exit "$rs"
}

usageWhich git

tarArgs=(--no-same-owner --no-same-permissions --no-xattrs)

currentTar="$top/vendor.tar.gz"
previousCommitHashFile="$top/vendor/git-commit-hash"
deleteDirectories=("$top/cache/" "$top/vendor/")
undoFlag=
cleanupFlag=
argBuildSHACheck=
atticPath=
while [ $# -gt 0 ]; do
    case $1 in
    --cleanup)
        cleanupFlag=1
        ;;
    --undo)
        undoFlag=1
        ;;
    *)
        if [ -z "$argBuildSHACheck" ]; then
            argBuildSHACheck=$1
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
    previousTar="$atticPath/$previousSHA.vendor.tar.gz"
    if [ ! -f "$previousTar" ]; then
        consoleError "No $previousTar - no undo"
        return 0
    fi
    deployTarFile "$atticPath" "$previousSHA"
}

deployAction() {
    local computedSHA deployTemp previousSHA argBuildSHACheck

    argBuildSHACheck=$1
    shift
    #   ____             _
    #  |  _ \  ___ _ __ | | ___  _   _
    #  | | | |/ _ \ '_ \| |/ _ \| | | |
    #  | |_| |  __/ |_) | | (_) | |_| |
    #  |____/ \___| .__/|_|\___/ \__, |
    #             |_|            |___/
    if [ ! -f "$currentTar" ]; then
        usage "$errEnv" "vendor.tar.gz is not uploaded here"
    fi

    #
    # Check the deployment file to make sure it matches what we know
    #
    # Create a deploy.123 directory, export .env and look at the value in it
    #
    deployTemp="$top/deploy.$$"
    if ! mkdir -p "$deployTemp"; then
        usage "$errEnv" "unable to create temp deploy directory"
    fi
    cd "$deployTemp/"
    # extract .env alone
    tar zxf "$currentTar" "${tarArgs[@]}" ".env"
    set -a
    . "$deployTemp/.env"
    set +a
    cd "$top"
    rm -rf "$deployTemp"

    #
    # Check things match
    #
    computedSHA="$(git rev-parse --short HEAD)"
    if [ "$APPLICATION_GIT_SHA" != "$computedSHA" ]; then
        usage "$errEnv" "Mismatch .env ($APPLICATION_GIT_SHA) != computed ($computedSHA)"
    fi
    if [ "$APPLICATION_GIT_SHA" != "$argBuildSHACheck" ]; then
        consoleRed "$deployTemp/.env"
        cat "$deployTemp/.env"
        usage "$errEnv" "Mismatch .env ($APPLICATION_GIT_SHA) != arg ($argBuildSHACheck)"
    fi

    #
    # Maintenance on
    #
    if [ -f "$previousCommitHashFile" ]; then
        #
        # .next and .previous are created here
        #
        cp "$previousCommitHashFile" "$atticPath/$argBuildSHACheck.previous"
        previousCommitHash=$(cat "$previousCommitHashFile")
        if [ -f "$atticPath/$argBuildSHACheck.next" ]; then
            nextFileContents=$(cat "$atticPath/$argBuildSHACheck.next")
            if [ "$nextFileContents" != "$argBuildSHACheck" ]; then
                echo "$(consoleError "Mismatch next file contents: ") $(consoleError "$nextFileContents")"
                echo "$(consoleError "           Overwriting with: ") $(consoleError "$argBuildSHACheck")"
            fi
        fi
        echo -n "$argBuildSHACheck" >"$atticPath/$previousCommitHash.next"
    fi

    mv "$currentTar" "$atticPath/$argBuildSHACheck.vendor.tar.gz"

    deployTarFile "$atticPath" "$argBuildSHACheck"
}

deployTarFile() {
    local tarBallPath shaPrefix vendorTar

    tarBallPath=$1
    shift

    shaPrefix=$1
    shift

    vendorTar="$tarBallPath/$shaPrefix.vendor.tar.gz"

    [ -f "$vendorTar" ] || usage $errEnv "Missing $vendorTar"

    bin/maintenance.sh on

    consoleInfo -n "Resetting to $shaPrefix ... "
    git reset --hard "$shaPrefix"

    consoleInfo "Removing ${deleteDirectories[*]} ... "
    rm -rf "${deleteDirectories[@]}"

    consoleInfo "Unpacking ./vendor/ ... "
    rm .env*
    tar zxf "$tarBallPath/$shaPrefix.vendor.tar.gz" "${tarArgs[@]}"
    date >"$tarBallPath/current.date"
    cp "$tarBallPath/current.date" "$tarBallPath/$shaPrefix.date"
    echo "$shaPrefix" >"$tarBallPath/current"

    consoleInfo -n "Metadata: "
    consoleGreen "$("$top/bin/ec2-metadata.php")"

    bin/maintenance.sh off
}

if test $undoFlag && test $cleanupFlag; then
    usage "$errArg" "--cleanup and --undo are mutually exclusive"
fi
start=$(beginTiming)
if test $cleanupFlag; then
    cleanupAction "$argBuildSHACheck"
elif test $undoFlag; then
    undoAction "$argBuildSHACheck"
else
    if [ -z "$argBuildSHACheck" ]; then
        usage "$errArg" "No argument build-sha-check passed"
    fi
    deployAction "$argBuildSHACheck"
fi
reportTiming "$start" "Done."
