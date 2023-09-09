#!/usr/bin/env bash
#
# Build PHP Application
#
# Tags
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# set -x # Debugging
set -eo pipefail

errEnv=1
errArg=2
targetFileName=${BUILD_TARGET:-app.tar.gz}

export BUILD_DATE_INITIAL=$(($(date +%s) + 0))
me=$(basename "${BASH_SOURCE[0]}")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

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
    consoleInfo "$me deployment [ --suffix versionSuffix ] ENV_VAR1 ENV_VAR2 ... -- file1 file2 dir3"
    echo
    consoleInfo "Build deployment using composer, adding environment values to .env and packaging vendor and additional files into final:"
    echo
    echo "$(consoleInfo -n "Target file") $(consoleValue -n "$targetFileName")"
    echo
    consoleInfo "Override target file generated with environment variable BUILD_TARGET"
    echo
    consoleInfo "Files are specified from the application root directory"
    exit "$rs"
}

usageWhich docker tar

if [ -z "$1" ]; then
    usage "$errArg" "No deployment"
fi
DEPLOYMENT=$1
export DEPLOYMENT
shift

# Save clean build environment to .build.env for other steps
declare -px >.build.env

# Sets the DEFAULT - can override with command line argument --suffix
if [ "$DEPLOYMENT" = "production" ]; then
    versionSuffix=rc
elif [ "$DEPLOYMENT" = "develop" ]; then
    versionSuffix=d
fi

optClean=
versionSuffix=
envVars=()
while [ $# -gt 0 ]; do
    case $1 in
    --)
        shift
        break
        ;;
    --clean)
        optClean=1
        ;;
    --suffix)
        shift
        versionSuffix=$1
        ;;
    *)
        envVars+=("$1")
        ;;
    esac
    shift
done

if [ $# -eq 0 ]; then
    usage $errEnv "Need to supply a list of files for application $targetFileName"
fi
for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
        missingFile+=("$tarFile")
    fi
done
if [ ${#missingFile[@]} -gt 0 ]; then
    usage $errEnv "Missing files: ${missingFile[*]}"
fi
initTime=$(beginTiming)

bigText Build | prefixLines "$(consoleGreen)"

consoleInfo "Installing build tools ..."

./bin/build/install/apt.sh
./bin/build/install/git.sh

consoleInfo "Tagging $DEPLOYMENT deployment with $versionSuffix ..."
./bin/build/pipeline/git-tag-version.sh --suffix "$versionSuffix"

#==========================================================================================
#
# Add needed tools
#

if hasHook make-env; then
    # this script usually runs ./bin/build/pipeline/make-env.sh
    runHook make-env "${envVars[@]}"
else
    ./bin/build/pipeline/make-env.sh "${envVars[@]}"
fi

if [ -d ./vendor ] || test $optClean; then
    consoleWarning "vendor directory should not exist before composer, deleting"
    rm -rf ./vendor 2>/dev/null || :
fi

./bin/build/pipeline/composer.sh

if [ ! -d ./vendor ]; then
    usage "$errArg" "Composer step did not create the vendor directory"
fi

[ -d ./.deploy ] && rm -rf ./.deploy
mkdir -p ./.deploy

git fetch -q
git rev-parse --short HEAD >./.deploy/git-commit-hash
versionTag=$(git describe --tags --abbrev=0)
echo -n "$versionTag" >./.deploy/version-tag

set -a
# shellcheck source=/dev/null
source .env
set +a

bigText "$APPLICATION_VERSION" | prefixLines "$(consoleGreen)"
echo

tar czf "$targetFileName" --owner=0 --group=0 --no-xattrs .env vendor/ .deploy/ "$@"

consoleInfo -n "Build completed "
reportTiming "$initTime"

# artifact: $targetFileName
