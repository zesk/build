#!/usr/bin/env bash
#
# Build PHP Application
#
# Tags
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Test: o test/tools/php-tools.sh
# Docs: o docs/_templates/tools/php.md

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

#
#
#
errorBuild=1000

# Install `php`
#
# If this fails it will output the installation log.
#
# Usage: phpInstall [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install `php`
# When this tool succeeds the `python` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: php.sh
#
phpInstall() {
  whichApt php php-cli "$@"
}

#
# Usage: {fn}
# Outputs the path to the PHP log file
#
phpLog() {
  if ! php -r "echo ini_get('error_log');" 2>/dev/null; then
    consoleError "php appears to be uninstalled" 1>&2
    return "$errorEnvironment"
  fi
}

#
# Uses basic database syntax of:
#
# - .deploy/variableName
#
# contents of file are exact value
#
# In addition, a `.env` is added to deployments
#
_deploymentGenerateValue() {
  local e=$1 hook=$2

  shift
  if [ -z "${!e}" ]; then
    if ! runHook "$hook" | tee "./.deploy/$e"; then
      return $errorEnvironment
    fi
  else
    printf %s "${!e}" | tee "./.deploy/$e"
  fi
}

#
# Build deployment using composer, adding environment values to .env and packaging vendor and additional
# files into target file, usually `BUILD_TARGET`
#
# Override target file generated with environment variable `BUILD_TARGET` which must ae set during build
# and on remote systems during deployment.
#
# Files are specified from the application root directory.
#
# `{fn}` generates the `.build.env` file, which contains the current environment and:
#
# - DEPLOYMENT
# - BUILD_TARGET
# - BUILD_START_TIMESTAMP
# - APPLICATION_TAG
# - APPLICATION_ID
#
# `DEPLOYMENT` is mapped to suffixes when `--suffix` not specified as follows:
#
# - `rc` - production
# - `d` - develop
# - `s` - staging
# - `t` - test
#
# Usage: {fn} [ --name tarFileName ] [ --deployment deployment ] [ --suffix versionSuffix ] [ --debug ] [ ENV_VAR1 ... ] -- file1 [ file2 ... ]
# Argument: --name tarFileName - Set BUILD_TARGET via command line (wins)
# Argument: --deployment deployment - Set DEPLOYMENT via command line (wins)
# Argument: --suffix versionSuffix - Set tag suffix via command line (wins, default inferred from deployment)
# Argument: --debug - Enable debugging. Defaults to BUILD_DEBUG.
# Argument: ENV_VAR1 - Optional. Environment variables to build into the deployed .env file
# Argument: -- - Required. Separates environment variables to file list
# Argument: file1 file2 dir3 ... - Required. List of files and directories to build into the application package.
# See: BUILD_TARGET.sh
phpBuild() {
  local e tagDeploymentFlag debuggingFlag optClean versionSuffix envVars missingFile initTime deployment
  local targetName

  usageRequireBinary _phpBuild tar

  for e in BUILD_TARGET BUILD_TIMESTAMP BUILD_DEBUG DEPLOYMENT APPLICATION_ID APPLICATION_TAG; do
    # shellcheck source=/dev/null
    . "bin/build/env/$e.sh" || return "$errorEnvironment"
  done

  targetName="$BUILD_TARGET"
  tagDeploymentFlag=1
  debuggingFlag=
  deployment=${DEPLOYMENT:-}
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
        deployment=$1
        ;;
      --no-tag | --skip-tag)
        tagDeploymentFlag=
        ;;
      --name)
        shift
        targetName=$1
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
    _phpBuild $errorEnvironment "Need to supply a list of files for application $BUILD_TARGET" || return $?
  fi
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  if [ ${#missingFile[@]} -gt 0 ]; then
    _phpBuild $errorEnvironment "Missing files: ${missingFile[*]}" || return $?
  fi

  # Sets the DEFAULT - can override with command line argument --suffix
  if [ "$deployment" = "production" ]; then
    versionSuffix=rc
  elif [ "$deployment" = "develop" ]; then
    versionSuffix=d
  elif [ "$deployment" = "staging" ]; then
    versionSuffix=s
  elif [ "$deployment" = "test" ]; then
    versionSuffix=t
  elif [ -z "$deployment" ]; then
    _phpBuild $errorArgument "DEPLOYMENT must be defined in the environment or passed as --deployment" || return $?
  fi
  if [ -z "$versionSuffix" ]; then
    _phpBuild $errorArgument "No version --suffix defined - usually unknown DEPLOYMENT: $deployment" || return $?
  fi
  if ! initTime=$(beginTiming); then
    _phpBuild $errorEnvironment "beginTiming failed" || return $?
  fi

  #
  # Everything above here is basically argument parsing and validation
  #
  export BUILD_START_TIMESTAMP=$initTime

  _phpBuildBanner Build PHP

  _phpEchoBar || :
  consoleInfo "Installing build tools ..." || :

  # Ensure we're up to date
  if ! aptInstall; then
    _phpBuild $errorArgument "Failed to install operating system basics" || return $?
  fi
  clearLine
  # Ensure we're up to date
  if ! gitInstall; then
    _phpBuild $errorArgument "Failed to install git" || return $?
  fi
  # shellcheck disable=SC2119
  if ! phpInstall git; then
    _phpBuild $errorArgument "Failed to install php" || return $?
  fi
  if test "$tagDeploymentFlag"; then
    consoleInfo "Tagging $deployment deployment with $versionSuffix ..."
    ./bin/build/pipeline/git-tag-version.sh --suffix "$versionSuffix"
  else
    clearLine
    consoleInfo "No tagging of this deployment"
  fi
  #==========================================================================================
  #
  # Generate .env
  #
  DEPLOYMENT="$deployment"
  if hasHook make-env; then
    # this script usually runs ./bin/build/pipeline/make-env.sh
    if ! runHook make-env "${envVars[@]+${envVars[@]}}" >.env; then
      consoleError "make-env hook failed $?" 1>&2
      return $errorEnvironment
    fi
  else
    if ! makeEnvironment "${envVars[@]+${envVars[@]}}" >.env; then
      consoleError makeEnvironment "${envVars[@]}" buildFailed "$?" 1>&2
      return $errorEnvironment
    fi
  fi
  if ! grep -q APPLICATION .env; then
    consoleError ".env file seems to be invalid:" 1>&2
    buildFailed ".env"
    return $errorEnvironment
  fi
  set -a
  # shellcheck source=/dev/null
  source .env
  set +a

  _phpEchoBar || :
  showEnvironment "${envVars[@]+${envVars[@]}}" || :

  if [ -d ./.deploy ] && ! rm -rf ./.deploy; then
    consoleError "Can not delete .deploy" 1>&2
    return "$errorEnvironment"
  fi
  if ! mkdir -p ./.deploy; then
    consoleError "Can not create .deploy" 1>&2
    return $errorEnvironment
  fi
  if ! APPLICATION_ID=$(_deploymentGenerateValue APPLICATION_ID application-id); then
    consoleError "APPLICATION_ID generation failed" 1>&2
    return "$errorEnvironment"
  fi
  if ! APPLICATION_TAG=$(_deploymentGenerateValue APPLICATION_TAG application-tag); then
    consoleError "APPLICATION_TAG generation failed" 1>&2
    return "$errorEnvironment"
  fi

  # Save clean build environment to .build.env for other steps
  if ! declare -px >.build.env; then
    consoleError "Generating .build.env failed" 1>&2
    return "$errorEnvironment"
  fi

  #==========================================================================================
  #
  # Build vendor
  #
  if [ -d ./vendor ] || test $optClean; then
    statusMessage consoleWarning "vendor directory should not exist before composer, deleting"
    rm -rf ./vendor 2>/dev/null || :
  fi

  clearLine || :
  # shellcheck disable=SC2119
  if ! phpComposer; then
    consoleError "Composer failed" 1>&2
    return "$errorEnvironment"
  fi

  if [ ! -d ./vendor ]; then
    _phpBuild "$errorArgument" "Composer step did not create the vendor directory"
    return $?
  fi

  _phpEchoBar
  _phpBuildBanner "Application ID" "$APPLICATION_ID"
  _phpEchoBar
  _phpBuildBanner "Application Tag" "$APPLICATION_TAG"
  _phpEchoBar

  createTarFile "$targetName" .env vendor/ .deploy/ "$@"

  consoleInfo -n "Build completed "
  reportTiming "$initTime"
}
_phpBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[@]#_}" "$@"
  return $?
}
_phpBuildBanner() {
  local label="$1"
  shift
  labeledBigText --top --prefix "PHP $(consoleMagenta). . . . $(consoleOrange)$(consoleBold) " --suffix "$(consoleReset)" --tween " $(consoleGreen)" "$label: " "$@"
}
_phpEchoBar() {
  consoleBoldRed "$(echoBar '.-+^`^+-')" || :
}

#
# Summary: Run Composer commands on code
#
# Runs composer validate and install on a directory.
#
# If this fails it will output the installation log.
#
# When this tool succeeds the `composer` tool has run on a source tree and the `vendor` directory and `composer.lock` are often updated.
#
# This tools does not install the `composer` binary into the local environment.
# fn: composer.sh
# Usage: composer.sh [ --help ] [ installDirectory ]
#
# Argument: installDirectory - You can pass a single argument which is the directory in your source tree to run composer. It should contain a `composer.json` file.
# Argument: --help - This help
#
# Example:     bin/build/pipeline/composer.sh ./app/
# Local Cache: This tool uses the local `.composer` directory to cache information between builds. If you cache data between builds for speed, cache the `.composer` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.
#
# Environment: BUILD_COMPOSER_VERSION - String. Default to `latest`. Used to run `docker run composer/$BUILD_COMPOSER_VERSION` on your code
#
# shellcheck disable=SC2120
phpComposer() {
  local start forceDocker installArgs quietLog dockerImage cacheDir composerBin composerDirectory savedWorking

  dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest}
  composerDirectory=.
  cacheDir=.composer
  forceDocker=
  start=$(beginTiming)

  while [ $# -gt 0 ]; do
    case $1 in
      --docker)
        consoleWarning "Requiring docker composer"
        forceDocker=1
        ;;
      --help)
        _phpComposer 0
        return $?
        ;;
      *)
        if [ "$composerDirectory" != "." ]; then
          _phpComposer "$errorArgument" "Unknown argument $1"
          return $?
        fi
        if [ ! -d "$1" ]; then
          _phpComposer "$errorArgument" "Directory does not exist: $1"
          return $?
        fi
        composerDirectory=$1
        consoleInfo "Using composer directory: $composerDirectory"
        ;;
    esac
    shift
  done

  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

  installArgs=("--ignore-platform-reqs")

  quietLog="$(buildQuietLog phpComposer)"
  consoleBoldRed -n "Composer ... "
  bigText "Install vendor" >>"$quietLog"

  if test $forceDocker; then
    consoleWarning -n "pulling ... "
    if ! docker pull "$dockerImage" >>"$quietLog" 2>&1; then
      consoleError "Failed to pull image $dockerImage" 1>&2
      buildFailed "$quietLog" 1>&2
      return "$errorBuild"
    fi
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
  else
    consoleWarning -n "installing ... "
    if ! aptInstall composer composer >>"$quietLog" 2>&1; then
      consoleError "Failed to install composer" 1>&2
      buildFailed "$quietLog" 1>&2
      return "$errorBuild"
    fi
    composerBin=(composer)
  fi
  consoleInfo -n "validating ... "

  savedWorking="$(pwd)"
  cd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  if ! "${composerBin[@]}" validate >>"$quietLog" 2>&1; then
    cd "$savedWorking" || :
    buildFailed "$quietLog"
    return "$errorBuild"
  fi

  consoleInfo -n "installing ... "
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog"
  if ! "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1; then
    cd "$savedWorking" || :
    buildFailed "$quietLog" 1>&2
    return "$errorBuild"
  fi
  cd "$savedWorking" || :
  reportTiming "$start" "completed in"
}
_phpComposer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  return "$?"
}
