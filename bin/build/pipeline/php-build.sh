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

export BUILD_DATE_INITIAL=$(($(date +%s) + 0))
export BUILD_TARGET=${BUILD_TARGET:=app.tar.gz}
me=$(basename "${BASH_SOURCE[0]}")
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
    consoleInfo "$me [ --name tarFileName ] [ --deployment deployment ] [ --suffix versionSuffix ] ENV_VAR1 ENV_VAR2 ... -- file1 file2 dir3"
    echo
    consoleInfo "Build deployment using composer, adding environment values to .env and packaging vendor and additional files into final:"
    echo
    echo "$(consoleInfo -n "Target file") $(consoleValue -n "$BUILD_TARGET")"
    echo
    consoleInfo "Override target file generated with environment variable BUILD_TARGET"
    echo
    consoleInfo "--name tarFileName       Set BUILD_TARGET via command line (wins)"
    consoleInfo "--deployment deployment  Set DEPLOYMENT via command line (wins)"
    consoleInfo "--suffix versionSuffix   Set tag suffix via command line"
    echo
    consoleInfo "Files are specified from the application root directory"
    exit "$rs"
}

usageWhich docker tar

export DEPLOYMENT

DEPLOYMENT=${DEPLOYMENT:-}
optClean=
versionSuffix=
envVars=()
while [ $# -gt 0 ]; do
    case $1 in
    --deployment)
        shift
        DEPLOYMENT=$1
        ;;
    --name)
        shift
        BUILD_TARGET=$1
        ;;
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
    usage $errEnv "Need to supply a list of files for application $BUILD_TARGET"
fi
for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
        missingFile+=("$tarFile")
    fi
done
if [ ${#missingFile[@]} -gt 0 ]; then
    usage $errEnv "Missing files: ${missingFile[*]}"
fi

# Sets the DEFAULT - can override with command line argument --suffix
if [ "$DEPLOYMENT" = "production" ]; then
    versionSuffix=rc
elif [ "$DEPLOYMENT" = "develop" ]; then
    versionSuffix=d
elif [ -z "$DEPLOYMENT" ]; then
    usage $errArg "DEPLOYMENT must be defined in the environment or passed as --deployment"
fi
if [ -z "$versionSuffix" ]; then
    usage $errArg "No version --suffix defined - usually unknown DEPLOYMENT: $DEPLOYMENT"
fi
initTime=$(beginTiming)

export BUILD_START_TIMESTAMP=$initTime
# Save clean build environment to .build.env for other steps
declare -px >.build.env

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

createTarFile "$BUILD_TARGET" .env vendor/ .deploy/ "$@"

consoleInfo -n "Build completed "
reportTiming "$initTime"

# artifact: $BUILD_TARGET
