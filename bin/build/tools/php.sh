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
  php -r "echo ini_get('error_log');" 2>/dev/null || _environment "php not installed" || return $?
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

  shift || :
  if [ -z "${!e}" ]; then
    runHook "$hook" | tee "./.deploy/$e" || _environment runHook "$hook" || return $?
  else
    printf %s "${!e}" | tee "./.deploy/$e" || _environment "writing .deploy/$e failed" || return $?
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
  local usage

  usage="_${FUNCNAME[0]}"

  usageRequireBinary "$usage" tar

  __usageArgument "$usage" buildEnvironmentLoad BUILD_TIMESTAMP BUILD_DEBUG DEPLOYMENT APPLICATION_ID APPLICATION_TAG || return $?
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
    [ -n "$arg" ] || __failArgument "$usage" "blank argument" || return $?
    case $1 in
      --debug)
        debuggingFlag=1
        ;;
      --deployment)
        shift || __failArgument "$usage" "$arg argument missing" || return $?
        deployment=$1
        ;;
      --no-tag | --skip-tag)
        tagDeploymentFlag=
        ;;
      --composer)
        shift || __failArgument "$usage" "$arg argument missing" || return $?
        [ -n "$1" ] || __failArgument "$usage" "$arg argument blank" || return $?
        composerArgs+=("$1")
        ;;
      --name)
        shift || __failArgument "$usage" "$arg argument missing" || return $?
        targetName=$1
        ;;
      --)
        shift || __failArgument "$usage" "$arg argument missing" || return $?
        break
        ;;
      --help)
        "$usage" 0
        return $?
        ;;
      --clean)
        optClean=1
        ;;
      --suffix)
        shift || __failArgument "$usage" "$arg argument missing" || return $?
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
  [ -n "$targetName" ] || __failArgument "$usage" "--name argument blank" || return $?
  [ $# -gt 0 ] || __failArgument "$usage" "Need to supply a list of files for application $(consoleCode "$targetName")" || return $?
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  [ ${#missingFile[@]} -eq 0 ] || __failEnvironment "$usage" "Missing files: ${missingFile[*]}" || return $?

  # Sets the DEFAULT - can override with command line argument --suffix
  if [ -z "$versionSuffix" ]; then
    case "$deployment" in
      production) versionSuffix=rc ;;
      develop) versionSuffix=d ;;
      staging) versionSuffix=s ;;
      test) versionSuffix=t ;;
      *)
        __failArgument "$usage" "--deployment $deployment unknown - can not set versionSuffix" || return $?
        ;;
    esac
    [ -n "$versionSuffix" ] || __failArgument "$usage" "No version --suffix defined - usually unknown DEPLOYMENT: $deployment" || return $?

  fi
  initTime=$(beginTiming) || __failEnvironment "$usage" beginTiming || return $?

  #
  # Everything above here is basically argument parsing and validation
  #
  export BUILD_START_TIMESTAMP=$initTime

  _phpBuildBanner Build PHP || :

  _phpEchoBar || :
  consoleInfo "Installing build tools ..." || :

  # Ensure we're up to date
  aptInstall || __failEnvironment "$usage" "Failed to install operating system basics" || return $?

  clearLine || :
  # Ensure we're up to date
  gitInstall || __failEnvironment "$usage" "Failed to install git" || return $?

  # shellcheck disable=SC2119
  phpInstall git || __failEnvironment "$usage" "Failed to install php" || return $?

  if test "$tagDeploymentFlag"; then
    consoleInfo "Tagging $deployment deployment with $versionSuffix ..."
    __usageEnvironment "$usage" gitTagVersion --suffix "$versionSuffix" || return $?
  else
    clearLine || :
    consoleInfo "No tagging of this deployment" || :
  fi
  #==========================================================================================
  #
  # Generate .env
  #
  DEPLOYMENT="$deployment"
  if hasHook make-env; then
    # this script usually runs ./bin/build/pipeline/make-env.sh
    __usageEnvironment "$usage" runHook make-env "${envVars[@]+${envVars[@]}}" >.env || return $?
  else
    __usageEnvironment "$usage" makeEnvironment "${envVars[@]+${envVars[@]}}" >.env || return $?
  fi
  if ! grep -q APPLICATION .env; then
    buildFailed ".env"
    __failEnvironment "$usage" ".env file seems to be invalid:" || return $?
  fi
  set -a
  # shellcheck source=/dev/null
  source .env || __failEnvironment "$usage" "source .env failed" || return $?
  set +a

  _phpEchoBar || :
  showEnvironment "${envVars[@]+${envVars[@]}}" || :

  [ ! -d ./.deploy ] || rm -rf ./.deploy || __failEnvironment "$usage" "Can not delete .deploy" || return $?

  mkdir -p ./.deploy || __failEnvironment "$usage" "Can not create .deploy" || return $?

  APPLICATION_ID=$(_deploymentGenerateValue APPLICATION_ID application-id) || __failEnvironment "$usage" "APPLICATION_ID generation failed" || return $?

  APPLICATION_TAG=$(_deploymentGenerateValue APPLICATION_TAG application-tag) || __failEnvironment "$usage" "APPLICATION_TAG generation failed" || return $?

  # Save clean build environment to .build.env for other steps
  declare -px >.build.env || __failEnvironment "$usage" "Generating .build.env failed" || return $?

  #==========================================================================================
  #
  # Build vendor
  #
  if [ -d ./vendor ] || test $optClean; then
    statusMessage consoleWarning "vendor directory should not exist before composer, deleting"
    __usageEnvironment "$usage" rm -rf ./vendor || return $?
  fi

  clearLine || :
  # shellcheck disable=SC2119
  __usageEnvironment "$usage" phpComposer "${composerArgs[@]+${composerArgs[@]}}" || return $?

  [ -d ./vendor ] || __failEnvironment "$usage" "Composer step did not create the vendor directory" || return $?

  _phpEchoBar || :
  _phpBuildBanner "Application ID" "$APPLICATION_ID" || :
  _phpEchoBar || :
  _phpBuildBanner "Application Tag" "$APPLICATION_TAG" || :
  _phpEchoBar || :

  __usageEnvironment "$usage" createTarFile "$targetName" .env vendor/ .deploy/ "$@" || return $?

  reportTiming "$initTime" "PHP built $(consoleCode "$targetName") in"
}
_phpBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@" || return $?
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
  local argument start forceDocker installArgs quietLog dockerImage cacheDir composerBin composerDirectory savedWorking
  local usage

  usage="_${FUNCNAME[0]}"

  dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest}
  composerDirectory=.
  cacheDir=.composer
  forceDocker=false
  start=$(beginTiming)

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --docker)
        consoleWarning "Requiring docker composer"
        forceDocker=true
        ;;
      --help)
        "$usage" 0
        return 0
        ;;
      *)
        [ "$composerDirectory" = "." ] || __failArgument "$usage" "Unknown argument $1" || return $?
        [ -d "$argument" ] || __failArgument "$usage" "Directory does not exist: $argument" || return $?
        composerDirectory="$argument"
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

  if $forceDocker; then
    consoleWarning -n "pulling ... "
    __usageEnvironmentQuiet "$usage" "$quietLog" docker pull "$dockerImage" || return $?
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
  else
    consoleWarning -n "installing ... "
    __usageEnvironmentQuiet "$usage" "$quietLog" aptInstall composer composer || return $?
    composerBin=(composer)
  fi
  consoleInfo -n "validating ... "

  savedWorking="$(pwd)"
  cd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  if ! "${composerBin[@]}" validate >>"$quietLog" 2>&1; then
    cd "$savedWorking" || :
    buildFailed "$quietLog" 1>&2 || _environment "${composerBin[@]}" validate failed || return $?
  fi

  consoleInfo -n "installing ... " || :
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog" || :
  if ! "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1; then
    cd "$savedWorking" || :
    buildFailed "$quietLog" 1>&2 || _environment "${composerBin[@]}" validate failed || return $?
  fi
  cd "$savedWorking" || :
  reportTiming "$start" "completed in" || :
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
  local this="${FUNCNAME[0]}"
  local usage="_$this"

  #                   _
  #   _ __ ___   __ _(_)_ __
  #  | '_ ` _ \ / _` | | '_ \
  #  | | | | | | (_| | | | | |
  #  |_| |_| |_|\__,_|_|_| |_|
  #

  init=$(beginTiming) || :
  quietLog="$(buildQuietLog "$this")" || __failEnvironment "$usage" "No buildQuietLog" || return $?

  buildDebugStart || :

  __usageEnvironment "$usage" dockerComposeInstall || return $?
  __usageEnvironment "$usage" phpComposer || return $?

  consoleInfo "Building test container" || :

  start=$(beginTiming) || :
  __usageEnvironment "$usage" _phpTestSetup || return $?
  __usageEnvironment "$usage" runOptionalHook test-setup || return $?

  export DOCKER_BUILDKIT=0
  # shellcheck disable=SC2094
  __usageEnvironmentQuiet "$usage" "$quietLog" docker-compose -f "./docker-compose.yml" build || return $?
  reportTiming "$start" "Built in" || :

  consoleInfo "Bringing up containers ..."

  start=$(beginTiming)
  # shellcheck disable=SC2094
  __usageEnvironmentQuiet "$usage" "$quietLog" docker-compose up -d || return $?
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
  local usage

  usage=_phpTest
  _phpTestCleanup || :
  __failEnvironment "$usage" "$@" || return $?
}
_phpTestResult() {
  local message=$1 color=$2 top=$3 bottom=$4 width=${5-16} thick="${6-3}"
  local gap="    "
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$top")")"$'\n'
  bigText "$message" | wrapLines "$top$gap$color" "$(consoleReset)$gap$bottom"
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$bottom")")"$'\n'
}
