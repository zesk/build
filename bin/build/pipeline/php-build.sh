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

errorEnvironment=1
errorArgument=2

export BUILD_DATE_INITIAL=$(($(date +%s) + 0))
export BUILD_TARGET=${BUILD_TARGET:=app.tar.gz}
me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

export usageDelimiter=@
usageOptions() {
    cat <<EOF
--name tarFileName@Set BUILD_TARGET via command line (wins)
--deployment deployment@Set DEPLOYMENT via command line (wins)
--suffix versionSuffix@Set tag suffix via command line (wins, default inferred from deployment)
--debug${usageDelimiter}Enable debugging. Defaults to BUILD_DEBUG.
ENV_VAR1 ENV_VAR2 ...@Required. Environment variables to build into the deployed .env file
--@Required. Separates environment variables to file list
file1 file2 dir3 ...@Required. List of files and directories to build into the application package.
EOF
}
usage() {
    usageMain "$me" "$@"
    exit $?
}
usageDescription() {
    cat <<EOF
Build deployment using composer, adding environment values to .env and packaging vendor and additional
files into final:

$(consoleInfo -n "Target file") $(consoleBoldRed -n "$BUILD_TARGET")

Override target file generated with environment variable $(consoleCode BUILD_TARGET) which must ae set during build
and on remote systems during deployment.

Files are specified from the application root directory.

This file generates the $(consoleCode .build.env) file, which contains the current environment and:

    $(consoleCode DEPLOYMENT)
    $(consoleCode BUILD_TARGET)
    $(consoleCode BUILD_START_TIMESTAMP)
    $(consoleCode APPLICATION_TAG)
    $(consoleCode APPLICATION_CHECKSUM)

$(consoleCode DEPLOYMENT) is mapped to suffixes when $(consoleLabel --suffix) not specified as follows:

EOF
    cat <<EOF | usageGenerator 10 | prefixLines "$(repeat 4 " ")"
rc production
d develop
s staging
t test
EOF
}

usageWhich docker tar

export DEPLOYMENT

debuggingFlag=
DEPLOYMENT=${DEPLOYMENT:-}
optClean=
versionSuffix=
envVars=()
while [ $# -gt 0 ]; do
    case $1 in
    --debug)
        debuggingFlag=1
        ;;
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

if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
fi
if test $debuggingFlag; then
    consoleWarning "Debugging is enabled"
    set -x
fi

if [ $# -eq 0 ]; then
    usage $errorEnvironment "Need to supply a list of files for application $BUILD_TARGET"
fi
for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
        missingFile+=("$tarFile")
    fi
done
if [ ${#missingFile[@]} -gt 0 ]; then
    usage $errorEnvironment "Missing files: ${missingFile[*]}"
fi

# Sets the DEFAULT - can override with command line argument --suffix
if [ "$DEPLOYMENT" = "production" ]; then
    versionSuffix=rc
elif [ "$DEPLOYMENT" = "develop" ]; then
    versionSuffix=d
elif [ "$DEPLOYMENT" = "staging" ]; then
    versionSuffix=s
elif [ "$DEPLOYMENT" = "test" ]; then
    versionSuffix=t
elif [ -z "$DEPLOYMENT" ]; then
    usage $errorArgument "DEPLOYMENT must be defined in the environment or passed as --deployment"
fi
if [ -z "$versionSuffix" ]; then
    usage $errorArgument "No version --suffix defined - usually unknown DEPLOYMENT: $DEPLOYMENT"
fi
initTime=$(beginTiming)

export BUILD_START_TIMESTAMP=$initTime

bigText Build | prefixLines "$(consoleGreen)"

consoleInfo "Installing build tools ..."

./bin/build/install/apt.sh
./bin/build/install/git.sh

consoleInfo "Tagging $DEPLOYMENT deployment with $versionSuffix ..."
./bin/build/pipeline/git-tag-version.sh --suffix "$versionSuffix"

#==========================================================================================
#
# Generate .env
#

if hasHook make-env; then
    # this script usually runs ./bin/build/pipeline/make-env.sh
    runHook make-env "${envVars[@]}"
else
    ./bin/build/pipeline/make-env.sh "${envVars[@]}"
fi

set -a
# shellcheck source=/dev/null
source .env
set +a

#==========================================================================================
#
# Generate .build.env
#
deployGitDefaultValue() {
    local e=$1 hook=$2

    shift
    if [ -z "${!e}" ]; then
        runHook "$hook" >"./.deploy/$e"
        cat "./.deploy/$e"
    else
        echo -n "${!e}" >"./.deploy/$e"
        echo -n "${!e}"
    fi
}

[ -d ./.deploy ] && rm -rf ./.deploy
mkdir -p ./.deploy

export APPLICATION_CHECKSUM
APPLICATION_CHECKSUM=$(deployGitDefaultValue APPLICATION_CHECKSUM application-checksum)
export APPLICATION_TAG
APPLICATION_TAG=$(deployGitDefaultValue APPLICATION_TAG application-tag)

# Save clean build environment to .build.env for other steps
declare -px >.build.env

#==========================================================================================
#
# Build vendor
#
if [ -d ./vendor ] || test $optClean; then
    consoleWarning "vendor directory should not exist before composer, deleting"
    rm -rf ./vendor 2>/dev/null || :
fi

./bin/build/pipeline/composer.sh

if [ ! -d ./vendor ]; then
    usage "$errorArgument" "Composer step did not create the vendor directory"
fi

bigText "$APPLICATION_TAG" | prefixLines "$(consoleGreen)"
echo
bigText "$APPLICATION_CHECKSUM" | prefixLines "$(consoleMagenta)"
echo

createTarFile "$BUILD_TARGET" .env vendor/ .deploy/ "$@"

consoleInfo -n "Build completed "
reportTiming "$initTime"

# artifact: $BUILD_TARGET
