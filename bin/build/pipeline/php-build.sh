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
set -eo pipefail
# set -x # Debugging

export BUILD_DATE_INITIAL=$(($(date +%s) + 0))
me=$(basename "${BASH_SOURCE[0]}")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

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
    consoleInfo "$me deployment"
    echo
    consoleInfo "Build deployment"
    echo
    exit "$rs"
}

if [ -z "$1" ]; then
    usage "$errArg" "No deployment"
fi
DEPLOYMENT=$1
export DEPLOYMENT
shift

optClean=
while [ $# -gt 0 ]; do
    case $1 in
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
./bin/build/git.sh
./bin/build/install/apt-utils.sh
usageWhich docker tar
whichApt ssh ssh-client

#==========================================================================================
#
# Add needed tools
#

if [ -x ./bin/pipeline/make-env.sh ]; then
    ./bin/pipeline/make-env.sh
else
    ./bin/build/pipeline/make-env.sh
fi

if [ -d ./vendor ]; then
    consoleWarning "vendor directory should not exist before composer, deleting"
    rm -rf ./vendor
fi

./bin/pipeline/step/composer-2.2.sh

git fetch -q
git rev-parse --short HEAD >./vendor/git-commit-hash
versionTag=$(git describe --tags --abbrev=0)
if [ "$DEPLOYMENT" != "production" ]; then
    consoleInfo "Marking version $versionTag"
    echo -n "$versionTag" >etc/db/version
else
    echo -n "$versionTag" >vendor/version-tag
fi
echo "APPLICATION_DISPLAY_VERSION=\"$(cat etc/db/version)\"" >>.env

set -a
source .env
set +a

echo "$(consoleInfo -n "Application display version is") $(consoleRed -n "$APPLICATION_DISPLAY_VERSION")"
echo
bigText "$APPLICATION_DISPLAY_VERSION" | prefixLines "$(consoleGreen)"
echo
if [ ! -d ./vendor ]; then
    usage "$errArg" "Composer step did not create the vendor directory"
fi

tar czf vendor.tar.gz --owner=0 --group=0 --no-xattrs vendor .env* etc/db/version

consoleInfo -n "Build completed "
reportTiming "$initTime"

# artifact: vendor.tar.gz
