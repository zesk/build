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
  logFile=$(__catchEnvironment "$usage" phpLog) || return $?
  [ -n "$logFile" ] || __throwEnvironment "$usage" "PHP log file is blank" || return $?
  if [ ! -f "$logFile" ]; then
    statusMessage printf -- "%s %s" "$(decorate file "$logFile")" "$(decorate warning "does not exist - creating")" 1>&2
    __catchEnvironment "$usage" touch "$logFile" || return $?
  elif isEmptyFile "$logFile"; then
    statusMessage printf -- "%s %s" "$(decorate file "$logFile")" "$(decorate warning "is empty")" 1>&2
  fi
  tail "$@" "$logFile"
}

#
# Usage: {fn}
# Outputs the path to the PHP log file
#
phpLog() {
  local usage="_${FUNCNAME[0]}"
  whichExists php || __throwEnvironment "$usage" "php not installed" || return $?
  php -r "echo ini_get('error_log');" 2>/dev/null || __throwEnvironment "$usage" "php installation issue" || return $?
}
_phpLog() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
# Outputs the path to the PHP ini file
#
phpIniFile() {
  local usage="_${FUNCNAME[0]}"
  whichExists php || __throwEnvironment "$usage" "php not installed" || return $?
  php -r "echo get_cfg_var('cfg_file_path');" 2>/dev/null || __throwEnvironment "$usage" "php installation issue" || return $?
}
_phpIniFile() {
  # _IDENTICAL_ usageDocument 1
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
    __catchEnvironment "$usage" hookRun --application "$home" "$hook" | __catchEnvironment "$usage" tee "$home/.deploy/$variableName" || return $?
  else
    __catchEnvironment "$usage" printf %s "${!variableName}" | __catchEnvironment "$usage" tee "$home/.deploy/$variableName" || return $?
  fi
}

_deploymentToSuffix() {
  local usage="$1" deployment="$2"
  case "$deployment" in
    production) versionSuffix=rc ;;
    staging) versionSuffix=s ;;
    test) versionSuffix=t ;;
    *)
      __throwArgument "$usage" "--deployment $deployment unknown - can not set versionSuffix" || return $?
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

  targetName="$(__catchEnvironment "$usage" deployPackageName)" || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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

  [ -n "$home" ] || home=$(__catchEnvironment "$usage" buildHome) || return $?
  [ -n "$targetName" ] || __throwArgument "$usage" "--name argument blank" || return $?
  [ $# -gt 0 ] || __throwArgument "$usage" "Need to supply a list of files for application $(decorate code "$targetName")" || return $?

  usageRequireBinary "$usage" tar || return $?
  __catchEnvironment "$usage" buildEnvironmentLoad "${environments[@]}" "${optionals[@]}" || return $?

  local missingFile tarFile
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  [ ${#missingFile[@]} -eq 0 ] || __throwEnvironment "$usage" "Missing files: ${missingFile[*]}" || return $?

  local initTime
  initTime=$(timingStart) || return $?

  #
  # Everything above here is basically argument parsing and validation
  #
  export BUILD_START_TIMESTAMP=$initTime

  _phpBuildBanner Build PHP || :

  _phpEchoBar || :
  statusMessage --first decorate info "Installing build tools ..." || :

  # Ensure we're up to date
  __catchEnvironment "$usage" packageInstall || return $?

  # shellcheck disable=SC2119
  __catchEnvironment "$usage" phpInstall || return $?

  #==========================================================================================
  #
  # Generate .env
  #
  local dotEnv="$home/.env"
  local clean=()

  clean+=("$dotEnv")
  if hasHook application-environment; then
    __catchEnvironment "$usage" hookRun --application "$home" application-environment "${environments[@]}" -- "${optionals[@]}" >"$dotEnv" || _clean $? "${clean[@]}" || return $?
  else
    __catchEnvironment "$usage" environmentFileApplicationMake "${environments[@]}" -- "${optionals[@]}" >"$dotEnv" || _clean $? "${clean[@]}" || return $?
  fi
  if ! grep -q APPLICATION "$dotEnv"; then
    buildFailed "$dotEnv" || __throwEnvironment "$usage" "$dotEnv file seems to be invalid:" || _clean $? "${clean[@]}" || return $?
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

  [ ! -d "$home/.deploy" ] || __catchEnvironment "$usage" rm -rf "$home/.deploy" || _clean $? "${clean[@]}" || return $?

  __catchEnvironment "$usage" mkdir -p "$home/.deploy" || _clean $? "${clean[@]}" || return $?
  clean+=("$home/.deploy")

  APPLICATION_ID=$(_deploymentGenerateValue "$usage" "$home" APPLICATION_ID application-id) || _clean $? "${clean[@]}" || return $?
  APPLICATION_TAG=$(_deploymentGenerateValue "$usage" "$home" APPLICATION_TAG application-tag) || _clean $? "${clean[@]}" || return $?

  # Save clean build environment to .build.env for other steps
  __catchEnvironment "$usage" declare -px >"$home/.build.env" || _clean $? "${clean[@]}" || return $?
  clean+=("$home/.build.env")

  #==========================================================================================
  #
  # Build vendor
  #
  if [ -d "$home/vendor" ] || $optClean; then
    statusMessage decorate warning "vendor directory should not exist before composer, deleting"
    __catchEnvironment "$usage" rm -rf "$home/vendor" || _clean $? "${clean[@]}" || return $?
    clean+=("$home/vendor")
  fi

  statusMessage decorate info "Running PHP composer ..."
  # shellcheck disable=SC2119
  __catchEnvironment "$usage" phpComposer "$home" "${composerArgs[@]+${composerArgs[@]}}" || _clean $? "${clean[@]}" || return $?

  [ -d "$home/vendor" ] || __throwEnvironment "$usage" "Composer step did not create the vendor directory" || _clean $? "${clean[@]}" || return $?

  _phpEchoBar
  _phpBuildBanner "Application ID" "$APPLICATION_ID"
  _phpEchoBar
  _phpBuildBanner "Application Tag" "$APPLICATION_TAG"
  _phpEchoBar

  __catchEnvironment "$usage" muzzle pushd "$home" || _clean $? "${clean[@]}" || return $?
  __catchEnvironment "$usage" tarCreate "$targetName" .env vendor/ .deploy/ "$@" || _undo $? muzzle popd || _clean $? "${clean[@]}" || return $?
  __catchEnvironment "$usage" muzzle popd || _clean $? "${clean[@]}" || return $?

  statusMessage --last timingReport "$initTime" "PHP built $(decorate code "$targetName") in"
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

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$home" ] || home=$(__catchEnvironment "$usage" buildHome) || return $?

  [ -f "$home/docker-compose.yml" ] || __catchEnvironment "$usage" "Requires $(decorate code "$home/docker-compose.yml")" || return $?

  local dca=()

  dca+=("-f" "$home/docker-compose.yml")

  statusMessage decorate info "Testing PHP in $(decorate file "$home")" || :

  local init quietLog

  init=$(timingStart) || return $?
  quietLog="$(__catchEnvironment "$usage" buildQuietLog "$usage")" || return $?

  buildDebugStart "${FUNCNAME[0]}" || :

  __catchEnvironment "$usage" dockerComposeInstall || return $?
  __catchEnvironment "$usage" phpComposer "$home" || return $?

  statusMessage decorate info "Building test container" || :

  local start undo=()
  start=$(timingStart) || return $?
  __catchEnvironment "$usage" _phpTestSetup "$usage" "$home" || return $?

  __catchEnvironment "$usage" muzzle pushd "$home" || return $?
  undo+=(muzzle popd)
  __catchEnvironment "$usage" hookRunOptional test-setup || _undo "$?" "${undo[@]}" || return $?

  __catchEnvironmentQuiet "$usage" "$quietLog" docker-compose "${dca[@]}" build || _undo "$?" "${undo[@]}" || return $?
  statusMessage timingReport "$start" "Built in" || :

  statusMessage decorate info "Bringing up containers ..." || _undo "$?" "${undo[@]}" || return $?

  start=$(__catchEnvironment "$usage" timingStart) || _undo "$?" "${undo[@]}" || return $?
  __catchEnvironmentQuiet "$usage" "$quietLog" docker-compose "${dca[@]}" up -d || _undo "$?" "${undo[@]}" || return $?
  statusMessage timingReport "$start" "Up in" || :

  start=$(timingStart) || return $?
  local reason=""
  if ! hookRun test-runner; then
    reason="test-runner hook failed"
    _phpTestResult Failed "$(decorate orange)" "❌" "🔥" 13 2
  else
    _phpTestResult "  Success " "$(decorate green)" "☘️ " "💙" 18 4
  fi
  decorate info "Bringing down containers ..." || :
  start=$(timingStart) || return $?
  __catchEnvironment "$usage" docker-compose "${dca[@]}" down || _phpTestCleanup "$usage" || __throwEnvironment "$usage" "docker-compose down" || return $?

  # Reset test environment ASAP
  _phpTestCleanup "$usage" || return $?
  statusMessage timingReport "$start" "Down in" || :
  if ! hookRunOptional test-cleanup; then
    reason="test-cleanup ALSO failed"
  fi
  [ -z "$reason" ] || __throwEnvironment "$usage" "$reason" || return $?
  buildDebugStop "${FUNCNAME[0]}" || :
  statusMessage timingReport "$init" "PHP Test completed in" || return $?
}
_phpTest() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_phpTestSetup() {
  local usage="$1" home="$2"

  __catchEnvironment "$usage" renameFiles "" ".$$.backup" hiding "$home/.env" "$home/.env.local"
}
_phpTestCleanup() {
  local usage="$1" item
  for item in "$home/.env" "$home/.env.local" "$home/vendor"; do
    if [ -f "$item" ] || [ -d "$item" ]; then
      __catchEnvironment "$usage" rm -rf "$item" || return $?
    fi
  done
  __catchEnvironment "$usage" renameFiles ".$$.backup" "" restoring "$home/.env" "$home/.env.local" || :
}
_phpTestResult() {
  local message=$1 color=$2 top=$3 bottom=$4 width=${5-16} thick="${6-3}"
  local gap="    "
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$top")")"$'\n'
  bigText "$message" | wrapLines "$top$gap$color" "$(decorate reset)$gap$bottom"
  repeat "$thick" "$(printf "%s" "$(repeat "$width" "$bottom")")"$'\n'
}
