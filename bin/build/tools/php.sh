#!/usr/bin/env bash
#
# Build PHP Application
#
# Tags
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Test: o test/tools/php-tools.sh
# Docs: o docs/_templates/tools/php.md

# Install `php`
#
# If this fails it will output the installation log.
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install `php`
# When this tool succeeds the `php` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
phpInstall() {
  packageWhich php php-common php-cli "$@"
}

# Uninstall `php`
#
# If this fails it will output the installation log.
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install
# Summary: Uninstall `php`
# When this tool succeeds the `php` binary is no longer available in the local operating system.
# Exit Code: 1 - If uninstallation fails
# Exit Code: 0 - If uninstallation succeeds
phpUninstall() {
  packageWhichUninstall php php-common php-cli "$@"
}

# Tail the PHP log
# See: tail
phpTailLog() {
  local usage="_${FUNCNAME[0]}"
  local logFile
  logFile=$(__usageEnvironment "$usage" phpLog) || return $?
  [ -n "$logFile" ] || __failEnvironment "$usage" "PHP log file is blank" || return $?
  if [ ! -f "$logFile" ]; then
    statusMessage -- printf "%s %s" "$(decorate file "$logFile")" "$(decorate warning "does not exist - creating")" 1>&2
    __usageEnvironment "$usage" touch "$logFile" || return $?
  elif isEmptyFile "$logFile"; then
    statusMessage -- printf "%s %s" "$(decorate file "$logFile")" "$(decorate warning "is empty")" 1>&2
  fi
  tail "$@" "$logFile"
}

#
# Usage: {fn}
# Outputs the path to the PHP log file
#
phpLog() {
  local usage="_${FUNCNAME[0]}"
  whichExists php || __failEnvironment "$usage" "php not installed" || return $?
  php -r "echo ini_get('error_log');" 2>/dev/null || __failEnvironment "$usage" "php installation issue" || return $?
}
_phpLog() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
# Outputs the path to the PHP ini file
#
phpIniFile() {
  local usage="_${FUNCNAME[0]}"
  whichExists php || __failEnvironment "$usage" "php not installed" || return $?
  php -r "echo get_cfg_var('cfg_file_path');" 2>/dev/null || __failEnvironment "$usage" "php installation issue" || return $?
}
_phpIniFile() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local usage="$1" home="$2" variableName="$3" hook="$4"
  if [ -z "${!variableName}" ]; then
    __usageEnvironment "$usage" runHook --application "$home" "$hook" | __usageEnvironment "$usage" tee "$home/.deploy/$variableName" || return $?
  else
    __usageEnvironment "$usage" printf %s "${!variableName}" | __usageEnvironment "$usage" tee "$home/.deploy/$variableName" || return $?
  fi
}

_deploymentToSuffix() {
  local usage="$1" deployment="$2"
  case "$deployment" in
    production) versionSuffix=rc ;;
    staging) versionSuffix=s ;;
    test) versionSuffix=t ;;
    *)
      __failArgument "$usage" "--deployment $deployment unknown - can not set versionSuffix" || return $?
      ;;
  esac
  printf "%s\n" "$versionSuffix"
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
# - BUILD_TARGET
# - BUILD_START_TIMESTAMP
# - APPLICATION_TAG
# - APPLICATION_ID
#
# Usage: {fn} [ --name tarFileName ] [ --suffix versionSuffix ] [ --debug ] [ ENV_VAR1 ... ] -- file1 [ file2 ... ]
# Argument: --skip-tag | --no-tag - Optional. Flag. Do not tag the release.
# Argument: --name tarFileName - String. Optional. Set BUILD_TARGET via command line (wins)
# Argument: --composer arg - Optional. Argument. Supply one or more arguments to `phpComposer` command. (Use multiple times)
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ENV_VAR1 - Optional. Environment variables to build into the deployed .env file
# Argument: -- - Required. Separates environment variables to file list
# Argument: file1 file2 dir3 ... - Required. List of files and directories to build into the application package.
# See: BUILD_TARGET.sh
phpBuild() {
  local usage="_${FUNCNAME[0]}"

  local environments=(BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_ID APPLICATION_TAG APPLICATION_VERSION)
  local optionals=(BUILD_DEBUG)

  local targetName optClean=false versionSuffix="" composerArgs=() home=""

  targetName="$(__usageEnvironment "$usage" deployPackageName)" || return $?

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --tag | --no-tag | --skip-tag)
        statusMessage decorate subtle "$argument is deprecated"
        ;;
      --composer)
        shift
        composerArgs+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --name)
        shift
        targetName=$(usageArgumentString "$usage" "name" "${1-}") || return $?
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
        versionSuffix=$(usageArgumentString "$usage" "versionSuffix" "${1-}") || return $?
        ;;
      --home)
        shift
        home=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        environments+=("$1")
        ;;
    esac
    shift
  done

  [ -n "$home" ] || home=$(__usageEnvironment "$usage" buildHome) || return $?
  [ -n "$targetName" ] || __failArgument "$usage" "--name argument blank" || return $?
  [ $# -gt 0 ] || __failArgument "$usage" "Need to supply a list of files for application $(decorate code "$targetName")" || return $?

  usageRequireBinary "$usage" tar || return $?
  __usageEnvironment "$usage" buildEnvironmentLoad "${environments[@]}" "${optionals[@]}" || return $?

  local missingFile tarFile
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  [ ${#missingFile[@]} -eq 0 ] || __failEnvironment "$usage" "Missing files: ${missingFile[*]}" || return $?

  local initTime
  initTime=$(__usageEnvironment "$usage" beginTiming) || return $?

  #
  # Everything above here is basically argument parsing and validation
  #
  export BUILD_START_TIMESTAMP=$initTime

  _phpBuildBanner Build PHP || :

  _phpEchoBar || :
  statusMessage --first decorate info "Installing build tools ..." || :

  # Ensure we're up to date
  __usageEnvironment "$usage" packageInstall || return $?

  # shellcheck disable=SC2119
  __usageEnvironment "$usage" phpInstall || return $?

  #==========================================================================================
  #
  # Generate .env
  #
  local dotEnv="$home/.env"
  local clean=()

  clean+=("$dotEnv")
  if hasHook application-environment; then
    __usageEnvironment "$usage" runHook --application "$home" application-environment "${environments[@]}" -- "${optionals[@]}" >"$dotEnv" || _clean $? "${clean[@]}" || return $?
  else
    __usageEnvironment "$usage" environmentFileApplicationMake "${environments[@]}" -- "${optionals[@]}" >"$dotEnv" || _clean $? "${clean[@]}" || return $?
  fi
  if ! grep -q APPLICATION "$dotEnv"; then
    buildFailed "$dotEnv" || __failEnvironment "$usage" "$dotEnv file seems to be invalid:" || _clean $? "${clean[@]}" || return $?
  fi
  local environment
  for environment in "${environments[@]}" "${optionals[@]}"; do
    # Safely load .env file
    # shellcheck disable=SC2163
    export "$environment"
    declare "$environment=$(environmentValueRead "$dotEnv" "$environment" "")"
  done
  _phpEchoBar || :

  environmentFileShow "${environments[@]}" -- "${optionals[@]}" || :

  [ ! -d "$home/.deploy" ] || __usageEnvironment "$usage" rm -rf "$home/.deploy" || _clean $? "${clean[@]}" || return $?

  __usageEnvironment "$usage" mkdir -p "$home/.deploy" || _clean $? "${clean[@]}" || return $?
  clean+=("$home/.deploy")

  APPLICATION_ID=$(_deploymentGenerateValue "$usage" "$home" APPLICATION_ID application-id) || _clean $? "${clean[@]}" || return $?
  APPLICATION_TAG=$(_deploymentGenerateValue "$usage" "$home" APPLICATION_TAG application-tag) || _clean $? "${clean[@]}" || return $?

  # Save clean build environment to .build.env for other steps
  __usageEnvironment "$usage" declare -px >"$home/.build.env" || _clean $? "${clean[@]}" || return $?
  clean+=("$home/.build.env")

  #==========================================================================================
  #
  # Build vendor
  #
  if [ -d "$home/vendor" ] || $optClean; then
    statusMessage decorate warning "vendor directory should not exist before composer, deleting"
    __usageEnvironment "$usage" rm -rf "$home/vendor" || _clean $? "${clean[@]}" || return $?
    clean+=("$home/vendor")
  fi

  statusMessage decorate info "Running PHP composer ..."
  # shellcheck disable=SC2119
  __usageEnvironment "$usage" phpComposer "$home" "${composerArgs[@]+${composerArgs[@]}}" || _clean $? "${clean[@]}" || return $?

  [ -d "$home/vendor" ] || __failEnvironment "$usage" "Composer step did not create the vendor directory" || _clean $? "${clean[@]}" || return $?

  _phpEchoBar
  _phpBuildBanner "Application ID" "$APPLICATION_ID"
  _phpEchoBar
  _phpBuildBanner "Application Tag" "$APPLICATION_TAG"
  _phpEchoBar

  __usageEnvironment "$usage" muzzle pushd "$home" || _clean $? "${clean[@]}" || return $?
  __usageEnvironment "$usage" tarCreate "$targetName" .env vendor/ .deploy/ "$@" || _undo $? muzzle popd || _clean $? "${clean[@]}" || return $?
  __usageEnvironment "$usage" muzzle popd || _clean $? "${clean[@]}" || return $?

  statusMessage --last reportTiming "$initTime" "PHP built $(decorate code "$targetName") in"
}
_phpBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@" || return $?
}
_phpBuildBanner() {
  local label="$1"
  shift
  labeledBigText --top --prefix "$(decorate blue PHP) $(decorate magenta). . . . $(decorate reset)$(decorate bold-orange) " --suffix "$(decorate reset)" --tween " $(decorate reset)$(decorate green)" "$label: " "$@"
}
_phpEchoBar() {
  decorate bold-blue "$(echoBar '.-+^`^+-')" || :
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
  local usage="_${FUNCNAME[0]}"

  local start dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest} composerDirectory="." cacheDir=".composer" forceDocker=false
  start=$(beginTiming)

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --docker)
        decorate warning "Requiring docker composer"
        forceDocker=true
        ;;
      *)
        [ "$composerDirectory" = "." ] || __failArgument "$usage" "Unknown argument $1" || return $?
        [ -d "$argument" ] || __failArgument "$usage" "Directory does not exist: $argument" || return $?
        composerDirectory="$argument"
        statusMessage decorate info "Composer directory: $(decorate file "$composerDirectory")"
        ;;
    esac
    shift
  done

  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

  local installArgs=("--ignore-platform-reqs") quietLog composerBin

  quietLog="$(__usageEnvironment "$usage" buildQuietLog "$usage")"
  bigText "Install vendor" >>"$quietLog"

  if $forceDocker; then
    statusMessage decorate info "Pulling composer ... "
    __usageEnvironmentQuiet "$usage" "$quietLog" docker pull "$dockerImage" || return $?
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
  else
    __usageEnvironmentQuiet "$usage" "$quietLog" packageInstall composer composer || return $?
    statusMessage decorate success "Installed composer ... " || :
    composerBin=(composer)
  fi
  statusMessage decorate info "Validating ... "

  __usageEnvironment "$usage" muzzle pushd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  "${composerBin[@]}" validate >>"$quietLog" 2>&1 || _undo $? muzzle popd || buildFailed "$quietLog" || return $?

  statusMessage decorate info "Application packages ... " || :
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog" || :
  "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1 || _undo $? muzzle popd || buildFailed "$quietLog" || return $?
  __usageEnvironment "$usage" muzzle popd || return $?
  statusMessage --last reportTiming "$start" "${FUNCNAME[0]} completed in" || :
}
_phpComposer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: --env-file envFile - Optional. File. Environment file to load.
# Argument: --home homeDirectory - Optional. Directory. Directory for application home.
# Test a docker-based PHP application during build
#
# Hook: test-setup - Move or copy files prior to docker-compose build to build test container"
# Hook: test-runner - Run PHP Unit and any other tests inside the container"
# Hook: test-cleanup - Reverse of test-setup hook actions"
phpTest() {
  local usage="_${FUNCNAME[0]}"

  local home=""

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --env-file)
        shift
        muzzle usageArgumentLoadEnvironmentFile "$usage" "$argument" "${1-}" || return $?
        statusMessage decorate info "Loaded $argument $(decorate file "$1") (wd: $(pwd))" || return $?
        ;;
      --home)
        shift
        home=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  [ -n "$home" ] || home=$(__usageEnvironment "$usage" buildHome) || return $?

  [ -f "$home/docker-compose.yml" ] || __usageEnvironment "$usage" "Requires $(decorate code "$home/docker-compose.yml")" || return $?

  local dca=()

  dca+=("-f" "$home/docker-compose.yml")

  statusMessage decorate info "Testing PHP in $(decorate file "$home")" || :

  local init quietLog

  init=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog="$(__usageEnvironment "$usage" buildQuietLog "$usage")" || return $?

  buildDebugStart "${FUNCNAME[0]}" || :

  __usageEnvironment "$usage" dockerComposeInstall || return $?
  __usageEnvironment "$usage" phpComposer "$home" || return $?

  statusMessage decorate info "Building test container" || :

  local start undo=()
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  __usageEnvironment "$usage" _phpTestSetup "$usage" "$home" || return $?

  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  undo+=(muzzle popd)
  __usageEnvironment "$usage" runOptionalHook test-setup || _undo "$?" "${undo[@]}" || return $?

  __usageEnvironmentQuiet "$usage" "$quietLog" docker-compose "${dca[@]}" build || _undo "$?" "${undo[@]}" || return $?
  statusMessage reportTiming "$start" "Built in" || :

  statusMessage decorate info "Bringing up containers ..." || _undo "$?" "${undo[@]}" || return $?

  start=$(__usageEnvironment "$usage" beginTiming) || _undo "$?" "${undo[@]}" || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" docker-compose "${dca[@]}" up -d || _undo "$?" "${undo[@]}" || return $?
  statusMessage reportTiming "$start" "Up in" || :

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  local reason=""
  if ! runHook test-runner; then
    reason="test-runner hook failed"
    _phpTestResult Failed "$(decorate orange)" "❌" "🔥" 13 2
  else
    _phpTestResult "  Success " "$(decorate green)" "☘️ " "💙" 18 4
  fi
  decorate info "Bringing down containers ..." || :
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  __usageEnvironment "$usage" docker-compose "${dca[@]}" down || _phpTestCleanup "$usage" || __failEnvironment "$usage" "docker-compose down" || return $?

  # Reset test environment ASAP
  _phpTestCleanup "$usage" || return $?
  statusMessage reportTiming "$start" "Down in" || :
  if ! runOptionalHook test-cleanup; then
    reason="test-cleanup ALSO failed"
  fi
  [ -z "$reason" ] || __failEnvironment "$usage" "$reason" || return $?
  buildDebugStop "${FUNCNAME[0]}" || :
  statusMessage reportTiming "$init" "PHP Test completed in" || return $?
}
_phpTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_phpTestSetup() {
  local usage="$1" home="$2"

  __usageEnvironment "$usage" renameFiles "" ".$$.backup" hiding "$home/.env" "$home/.env.local"
}
_phpTestCleanup() {
  local usage="$1" item
  for item in "$home/.env" "$home/.env.local" "$home/vendor"; do
    if [ -f "$item" ] || [ -d "$item" ]; then
      __usageEnvironment "$usage" rm -rf "$item" || return $?
    fi
  done
  __usageEnvironment "$usage" renameFiles ".$$.backup" "" restoring "$home/.env" "$home/.env.local" || :
}
_phpTestResult() {
  local message=$1 color=$2 top=$3 bottom=$4 width=${5-16} thick="${6-3}"
  local gap="    "
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$top")")"$'\n'
  bigText "$message" | wrapLines "$top$gap$color" "$(decorate reset)$gap$bottom"
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$bottom")")"$'\n'
}
