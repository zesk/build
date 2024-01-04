#!/usr/bin/env bash
#
# Build PHP Application
#
# Tags
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# set -x # Debugging
set -eou pipefail

errorEnvironment=1
errorArgument=2

export BUILD_DATE_INITIAL=$(($(date +%s) + 0))
export BUILD_TARGET=${BUILD_TARGET:=app.tar.gz}
me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

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
    printf %s "${!e}" >"./.deploy/$e"
    printf %s "${!e}"
  fi
}

_phpBuildUsage() {
  usageDocument "bin/build/pipeline/$me" "phpBuild" "$@"
  return $?
}
# Build deployment using composer, adding environment values to .env and packaging vendor and additional
# files into final: `BUILD_TARGET` (defaults to `app.tar.gz`)
#
# Override target file generated with environment variable $(consoleCode BUILD_TARGET) which must ae set during build
# and on remote systems during deployment.
#
# Files are specified from the application root directory.
#
# This file generates the `.build.env` file, which contains the current environment and:
#
# - DEPLOYMENT
# - BUILD_TARGET
# - BUILD_START_TIMESTAMP
# - APPLICATION_TAG
# - APPLICATION_CHECKSUM
#
# `DEPLOYMENT` is mapped to suffixes when `--suffix` not specified as follows:
#
# - `rc` - production
# - `d` - develop
# - `s` - staging
# - `t` - test
#
# Argument: --name tarFileName - Set BUILD_TARGET via command line (wins)
# Argument: --deployment deployment - Set DEPLOYMENT via command line (wins)
# Argument: --suffix versionSuffix - Set tag suffix via command line (wins, default inferred from deployment)
# Argument: --debug - Enable debugging. Defaults to BUILD_DEBUG.
# Argument: ENV_VAR1 - Optional. Environment variables to build into the deployed .env file
# Argument: -- - Required. Separates environment variables to file list
# Argument: file1 file2 dir3 ... - Required. List of files and directories to build into the application package.
#
phpBuild() {
  local tagDeploymentFlag debuggingFlag optClean versionSuffix envVars missingFile initTime

  usageRequireBinary usage docker tar

  export DEPLOYMENT

  tagDeploymentFlag=1
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
      --no-tag | --skip-tag)
        tagDeploymentFlag=
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
    _phpBuildUsage $errorEnvironment "Need to supply a list of files for application $BUILD_TARGET"
    return $?
  fi
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  if [ ${#missingFile[@]} -gt 0 ]; then
    _phpBuildUsage $errorEnvironment "Missing files: ${missingFile[*]}"
    return $?
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
    _phpBuildUsage $errorArgument "DEPLOYMENT must be defined in the environment or passed as --deployment"
    return $?
  fi
  if [ -z "$versionSuffix" ]; then
    _phpBuildUsage $errorArgument "No version --suffix defined - usually unknown DEPLOYMENT: $DEPLOYMENT"
    return $?
  fi
  initTime=$(beginTiming)

  export BUILD_START_TIMESTAMP=$initTime

  bigText Build | prefixLines "$(consoleGreen)"

  consoleInfo "Installing build tools ..."

  aptInstall
  gitInstall

  if test "$tagDeploymentFlag"; then
    consoleInfo "Tagging $DEPLOYMENT deployment with $versionSuffix ..."
    ./bin/build/pipeline/git-tag-version.sh --suffix "$versionSuffix"
  else
    consoleInfo "No tagging of this deployment"
  fi
  #==========================================================================================
  #
  # Generate .env
  #

  if hasHook make-env; then
    # this script usually runs ./bin/build/pipeline/make-env.sh
    if ! runHook make-env "${envVars[@]}" >.env; then
      consoleError "make-env hook failed $?" 1>&2
      return $errorEnvironment
    fi
  else
    if ! makeEnvironment "${envVars[@]}" >.env; then
      consoleError makeEnvironment "${envVars[@]}" buildFailed "$?" 1>&2
      return $errorEnvironment
    fi
  fi
  showEnvironment "${envVars[@]}"

  if ! grep -q APPLICATION .env; then
    consoleError ".env file seems to be invalid:" 1>&2
    buildFailed ".env"
    return $errorEnvironment
  fi
  set -a
  # shellcheck source=/dev/null
  source .env
  set +a

  [ ! -d ./.deploy ] || rm -rf ./.deploy
  mkdir -p ./.deploy || return $errorEnvironment

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
    _phpBuildUsage "$errorArgument" "Composer step did not create the vendor directory"
    return $?
  fi

  bigText "$APPLICATION_TAG" | prefixLines "$(consoleGreen)"
  echo
  bigText "$APPLICATION_CHECKSUM" | prefixLines "$(consoleMagenta)"
  echo

  createTarFile "$BUILD_TARGET" .env vendor/ .deploy/ "$@"

  consoleInfo -n "Build completed "
  reportTiming "$initTime"
}

phpBuild "$@"

# artifact: $BUILD_TARGET
