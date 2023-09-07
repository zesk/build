#!/usr/bin/env bash
#
# Build PHP Application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

#  ▞▀▖      ▗▀▖▗             ▐  ▗
#  ▌  ▞▀▖▛▀▖▐  ▄ ▞▀▌▌ ▌▙▀▖▝▀▖▜▀ ▄ ▞▀▖▛▀▖
#  ▌ ▖▌ ▌▌ ▌▜▀ ▐ ▚▄▌▌ ▌▌  ▞▀▌▐ ▖▐ ▌ ▌▌ ▌
#  ▝▀ ▝▀ ▘ ▘▐  ▀▘▗▄▘▝▀▘▘  ▝▀▘ ▀ ▀▘▝▀ ▘ ▘

errEnv=1
errArg=2
targetFileName=${BUILD_TARGET:-app.tar.gz}

set -eo pipefail
# set -x # Debugging

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
    consoleInfo "$me deployment -e ENV_VAR -e ANOTHER_ENV_VAR file1 file2 dir3"
    echo
    consoleInfo "Build deployment using composer, adding environment values to .env and packaging vendor and additional files into final:"
    echo
    echo "$(consoleInfo -n "Target file") $(consoleValue -n "$targetFileName")"
    echo
    consoleInfo "Override target file generated with environment variable BUILD_TARGET"
    exit "$rs"
}

usageWhich docker tar

if [ -z "$1" ]; then
    usage "$errArg" "No deployment"
fi
DEPLOYMENT=$1
export DEPLOYMENT
shift

optClean=
envVars=()
while [ $# -gt 0 ]; do
    case $1 in
    -e)
        envVars+=("$1")
        ;;
    --clean)
        optClean=1
        ;;
    *)
        usage "$errArg" "Unknown parameter $1"
        ;;
    esac
    shift
done

initTime=$(beginTiming)

bigText Build | prefixLines "$(consoleGreen)"

consoleInfo "Installing build tools ..."

./bin/build/install/apt.sh
./bin/build/install/git.sh

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
