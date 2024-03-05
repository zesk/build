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
# Argument: --composer arg - Optional. Argument. Supply one or more arguments to `phpComposer` command. (Use multiple times)
# Argument: --deployment deployment - Set DEPLOYMENT via command line (wins)
# Argument: --suffix versionSuffix - Set tag suffix via command line (wins, default inferred from deployment)
# Argument: --debug - Enable debugging. Defaults to BUILD_DEBUG.
# Argument: ENV_VAR1 - Optional. Environment variables to build into the deployed .env file
# Argument: -- - Required. Separates environment variables to file list
# Argument: file1 file2 dir3 ... - Required. List of files and directories to build into the application package.
# See: BUILD_TARGET.sh
phpBuild() {
  local arg e tagDeploymentFlag debuggingFlag optClean versionSuffix envVars missingFile initTime deployment composerArgs
  local targetName

  usageRequireBinary "_${FUNCNAME[0]}" tar

  if ! buildEnvironmentLoad BUILD_TIMESTAMP BUILD_DEBUG DEPLOYMENT APPLICATION_ID APPLICATION_TAG; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Missing environment" || return $?
  fi
  targetName="$(deployPackageName)"
  tagDeploymentFlag=1
  debuggingFlag=
  deployment=${DEPLOYMENT:-}
  optClean=
  versionSuffix=
  envVars=()
  composerArgs=()
  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "Blank argument" || return $?
    fi
    case $1 in
      --debug)
        debuggingFlag=1
        ;;
      --deployment)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "shift $arg failed" || return $?
        deployment=$1
        ;;
      --no-tag | --skip-tag)
        tagDeploymentFlag=
        ;;
      --composer)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "shift $arg failed" || return $?
        if [ -z "$1" ]; then
          "_${FUNCNAME[0]}" "$errorArgument" "blank --composer argument" || return $?$()
        fi
        composerArgs+=("$1")
        ;;
      --name)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "shift $arg failed" || return $?
        targetName=$1
        ;;
      --)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "shift $arg failed" || return $?
        break
        ;;
      --clean)
        optClean=1
        ;;
      --suffix)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "shift $arg failed" || return $?
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

  if [ -z "$targetName" ]; then
    "_${FUNCNAME[0]}" "$errorArgument" "--name is blank" || return $?
  fi
  if [ $# -eq 0 ]; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Need to supply a list of files for application $targetName" || return $?
  fi
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  if [ ${#missingFile[@]} -gt 0 ]; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Missing files: ${missingFile[*]}" || return $?
  fi

  # Sets the DEFAULT - can override with command line argument --suffix
  if [ -z "$versionSuffix" ]; then
    case "$deployment" in
      production) versionSuffix=rc ;;
      develop) versionSuffix=d ;;
      staging) versionSuffix=s ;;
      test) versionSuffix=t ;;
      *)
        "_${FUNCNAME[0]}" "$errorArgument" "--deployment $deployment unknown - can not set versionSuffix" || return $?
        ;;
    esac
    if [ -z "$versionSuffix" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "No version --suffix defined - usually unknown DEPLOYMENT: $deployment" || return $?
    fi
  fi
  if ! initTime=$(beginTiming); then
    "_${FUNCNAME[0]}" "$errorEnvironment" "beginTiming failed" || return $?
  fi

  #
  # Everything above here is basically argument parsing and validation
  #
  export BUILD_START_TIMESTAMP=$initTime

  _phpBuildBanner Build PHP || :

  _phpEchoBar || :
  consoleInfo "Installing build tools ..." || :

  # Ensure we're up to date
  if ! aptInstall; then
    "_${FUNCNAME[0]}" "$errorArgument" "Failed to install operating system basics" || return $?
  fi
  clearLine || :
  # Ensure we're up to date
  if ! gitInstall; then
    "_${FUNCNAME[0]}" "$errorArgument" "Failed to install git" || return $?
  fi
  # shellcheck disable=SC2119
  if ! phpInstall git; then
    "_${FUNCNAME[0]}" "$errorArgument" "Failed to install php" || return $?
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
      "_${FUNCNAME[0]}" "$errorEnvironment" "make-env hook failed $?" || return $?
    fi
  else
    if ! makeEnvironment "${envVars[@]+${envVars[@]}}" >.env; then
      "_${FUNCNAME[0]}" "$errorEnvironment" makeEnvironment "${envVars[@]}" buildFailed "$?" || return $?
    fi
  fi
  if ! grep -q APPLICATION .env; then
    consoleError ".env file seems to be invalid:" 1>&2
    buildFailed ".env"
    return "$errorEnvironment"
  fi
  set -a
  # shellcheck source=/dev/null
  source .env
  set +a

  _phpEchoBar || :
  showEnvironment "${envVars[@]+${envVars[@]}}" || :

  if [ -d ./.deploy ] && ! rm -rf ./.deploy; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Can not delete .deploy" || return $?
  fi
  if ! mkdir -p ./.deploy; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Can not create .deploy" || return $?
  fi
  if ! APPLICATION_ID=$(_deploymentGenerateValue APPLICATION_ID application-id); then
    "_${FUNCNAME[0]}" "$errorEnvironment" "APPLICATION_ID generation failed" || return $?
  fi
  if ! APPLICATION_TAG=$(_deploymentGenerateValue APPLICATION_TAG application-tag); then
    "_${FUNCNAME[0]}" "$errorEnvironment" "APPLICATION_TAG generation failed" || return $?
  fi

  # Save clean build environment to .build.env for other steps
  if ! declare -px >.build.env; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Generating .build.env failed" || return $?
  fi

  #==========================================================================================
  #
  # Build vendor
  #
  if [ -d ./vendor ] || test $optClean; then
    statusMessage consoleWarning "vendor directory should not exist before composer, deleting"
    if ! rm -rf ./vendor; then
      "_${FUNCNAME[0]}" "$errorEnvironment" "Unable to delete ./vendor" || return $?
    fi
  fi

  clearLine || :
  # shellcheck disable=SC2119
  if ! phpComposer "${composerArgs[@]+${composerArgs[@]}}"; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Composer failed" || return $?
  fi

  if [ ! -d ./vendor ]; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "Composer step did not create the vendor directory" || return $?
  fi

  _phpEchoBar || :
  _phpBuildBanner "Application ID" "$APPLICATION_ID" || :
  _phpEchoBar || :
  _phpBuildBanner "Application Tag" "$APPLICATION_TAG" || :
  _phpEchoBar || :

  if ! createTarFile "$targetName" .env vendor/ .deploy/ "$@"; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "createTarFile $targetName failed" || return $?
  fi

  reportTiming "$initTime" "PHP built $(consoleCode "$targetName") in"
}
_phpBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[@]#_}" "$@"
  return $?
}
_phpBuildBanner() {
  local label="$1"
  shift
  labeledBigText --top --prefix "$(consoleBlue PHP) $(consoleMagenta). . . . $(consoleReset)$(consoleBoldOrange) " --suffix "$(consoleReset)" --tween " $(consoleReset)$(consoleGreen)" "$label: " "$@"
}
_phpEchoBar() {
  consoleBoldBlue "$(echoBar '.-+^`^+-')" || :
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

# fn: {base}
# Usage: {fn} deployment
# Argument: deployment - Required. String. `production` or `develop`
# Test a docker-based PHP application during build
#
# Hook: test-setup - Move or copy files prior to docker-compose build to build test container"
# Hook: test-runner - Run PHP Unit and any other tests inside the container"
# Hook: test-cleanup - Reverse of test-setup hook actions"
phpTest() {
  local init start quietLog success

  #                   _
  #   _ __ ___   __ _(_)_ __
  #  | '_ ` _ \ / _` | | '_ \
  #  | | | | | | (_| | | | | |
  #  |_| |_| |_|\__,_|_|_| |_|
  #

  init=$(beginTiming) || :
  if ! quietLog="$(buildQuietLog "${FUNCNAME[0]}")"; then
    _phpTest "$errorEnvironment" "No buildQuietLog" || return $?
  fi

  buildDebugStart || :

  if ! dockerComposeInstall; then
    _phpTest "$errorEnvironment" "dockerComposeInstall failed" || return $?
  fi
  if ! phpComposer; then
    _phpTest "$errorEnvironment" "phpComposer failed" || return $?
  fi

  consoleInfo "Building test container" || :

  start=$(beginTiming) || :
  if ! _phpTestSetup; then
    _phpTest "$errorEnvironment" "phpComposer failed" || return $?
  fi
  if ! runOptionalHook test-setup; then
    _phpTestCleanupFailed "test-setup failed" || return $?
  fi

  export DOCKER_BUILDKIT=0
  if ! docker-compose -f "./docker-compose.yml" build >>"$quietLog"; then
    buildFailed "$quietLog"
    _phpTestCleanupFailed "docker-compose failed" || return $?
  fi
  reportTiming "$start" "Built in" || :

  consoleInfo "Bringing up containers ..."

  start=$(beginTiming)
  if ! docker-compose up -d >>"$quietLog" 2>&1; then
    buildFailed "$quietLog"
    _phpTestCleanupFailed "docker-compose up failed" || return $?
  fi
  reportTiming "$start" "Up in"

  start=$(beginTiming) || :
  success=true
  if ! runHook test-runner; then
    success=false
    _phpTestResult Failed "$(consoleOrange)" "❌" "🔥" 13 2
  else
    _phpTestResult "  Success " "$(consoleGreen)" "☘️ " "💙" 18 4
  fi
  consoleInfo "Bringing down containers ..." || :
  start=$(beginTiming) || :
  if ! docker-compose down 2>/dev/null; then
    _phpTestCleanupFailed "docker-compose DOWN failed" || return $?
  fi
  # Reset test environment ASAP
  _phpTestCleanup || :
  reportTiming "$start" "Down in" || :
  if ! runOptionalHook test-cleanup; then
    consoleError "test-cleanup ALSO failed"
    success=false
  fi
  buildDebugStop || :

  reportTiming "$init" "PHP Test completed in" || :
  $success
}
_phpTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_phpTestSetup() {
  renameFiles "" ".$$.backup" hiding .env .env.local
}
_phpTestCleanup() {
  for i in .env .env.local ./vendor; do
    if [ -f "$i" ] || [ -d "$i" ]; then
      rm -rf "$i" || :
    fi
  done
  renameFiles ".$$.backup" "" restoring .env .env.local || :
}
_phpTestCleanupFailed() {
  _phpTestCleanup || :
  _phpTest "$errorEnvironment" "$@" || return $?
}
_phpTestResult() {
  local message=$1 color=$2 top=$3 bottom=$4 width=${5-16} thick="${6-3}"
  local gap="    "
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$top")")"$'\n'
  bigText "$message" | wrapLines "$top$gap$color" "$(consoleReset)$gap$bottom"
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$bottom")")"$'\n'
}
