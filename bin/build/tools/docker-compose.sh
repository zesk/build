#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/docker-compose.md
# Test: ./test/tools/docker-compose-tests.sh

# Wrapper for `docker-compose` or `docker compose`
dockerComposeWrapper() {
  local handler="_${FUNCNAME[0]}"

  whichExists docker || throwEnvironment "$handler" "Missing docker binary" || return $?
  if muzzle docker compose --help; then
    catchEnvironment "$handler" docker compose "$@" || return $?
  else
    whichExists docker-compose || throwEnvironment "$handler" "Missing docker-compose binary" || return $?
    catchEnvironment "$handler" docker-compose "$@" || return $?
  fi
}
_dockerComposeWrapper() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install `docker-compose`
#
# If this fails it will output the installation log.
#
# Argument: package - Additional packages to install (using `pipInstall`)
# Summary: Install `docker-compose`
# When this tool succeeds the `docker-compose` binary is available in the local operating system.
# Return Code: 1 - If installation fails
# Return Code: 0 - If installation succeeds
# Binary: docker-compose.sh
# See: pipInstall
#
dockerComposeInstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  whichExists docker || throwEnvironment "$handler" "Missing docker binary" || return $?
  if muzzle docker compose --help; then
    return 0
  fi
  local name="docker-compose"
  if pythonPackageInstalled "$name"; then
    return 0
  fi
  pipInstall --handler "$handler" "$name" "$@"
}
_dockerComposeInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install `docker-compose`
#
# If this fails it will output the installation log.
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install (using apt)
# Summary: Install `docker-compose`
# When this tool succeeds the `docker-compose` binary is available in the local operating system.
# Return Code: 1 - If installation fails
# Return Code: 0 - If installation succeeds
# Binary: docker-compose.sh
#
dockerComposeUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if muzzle docker compose --help; then
    return 0
  fi
  local name="docker-compose"
  if ! pythonPackageInstalled "$name"; then
    return 0
  fi
  pipUninstall --handler "$handler" "$name" || return $?
}
_dockerComposeUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is docker compose currently running?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 1 - Not running
# Return Code: 0 - Running
dockerComposeIsRunning() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local temp
  temp=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" dockerCompose ps --format json >"$temp" || returnClean $? "$temp" || return $?
  local exitCode=1
  fileIsEmpty "$temp" || exitCode=0
  catchEnvironment "$handler" rm -rf "$temp" || return $?
  return $exitCode
}
_dockerComposeIsRunning() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List of docker compose commands
# Updated: 2025-04-07
# Require-Update: 90
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dockerComposeCommandList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # Sampled 2025
  printf -- "%s\n" attach build commit config cp create down events exec export images kill logs ls pause port ps pull push restart rm run scale start stats stop top unpause up version wait watch | sort -u
}
_dockerComposeCommandList() {
  ! false || dockerComposeCommandList --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is this a docker compose command?
# Argument: command - String. Required. The command to test.
# See: dockerComposeCommandList
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 0 - Yes, it is.
# Return Code: 1 - No, it is not.
isDockerComposeCommand() {
  local handler="_${FUNCNAME[0]}" command="${1-}"

  [ -n "$command" ] || throwArgument "$handler" "command is blank" || return $?
  if [ "$command" = "--help" ]; then
    "$handler" 0
    return $?
  fi
  grep -q -e "$(quoteGrepPattern "$command")" < <(dockerComposeCommandList)
}
_isDockerComposeCommand() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# docker compose wrapper with automatic .env support
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --production - Flag. Production container build. Shortcut for `--deployment production` (uses `.PRODUCTION.env`)
# Argument: --staging - Flag. Staging container build. Shortcut for `--deployment staging` (uses `.STAGING.env`)
# Argument: --deployment deploymentName - String. Deployment name to use. (uses `.$(uppercase "$deploymentName").env`)
# Argument: --volume - String. Name of the volume associated with the container to preserve or delete.
# Argument: --build - Flag. `build` command with volume management
# Argument: --clean - Flag. Delete the volume prior to building.
# Argument: --keep - Flag. Keep the volume during build.
# Argument: --default-env | --env environmentNameValue - EnvironmentNameValue. An environment variable name and value (in the form `NAME=value` to require in the `.env` file.
# Argument: --env environmentNameValue - EnvironmentNameValue. An environment variable name and value (in the form `NAME=value` to require in the `.env` file. If set already in the file or in the environment then has no effect.
# Argument: --arg environmentNameValue - EnvironmentNameValue. Passed as an ARG to the build environment – a variable name and value (in the form `NAME=value` to require in the `.env` file. If set already in the file or in the environment then has no effect.
# Argument: composeCommand - You can send any compose command and arguments thereafter are passed to `docker compose`
# Environment files are managed automatically by this function (with backups).
# Environment files are named in uppercase after the deployment as `.DEPLOYMENT.env` in the home directory
#
# So, `.STAGING.env` and `.PRODUCTION.env` are the default environments. They are copied into `.env` with any additional required
# default environment variables (including `DEPLOYMENT=`), and then this `.env` file serves as the basis for both the
# `docker-compose.yml` generation (any variable defined here is mapped into this file - by default) and ultimately may be
# copied into the container as configuration settings.
#
# Custom deployment settings can be set up using the `--deployment deploymentName` argument.
#
# Volume name, by default is named after the directory name of the project suffixed with `_database_data`.
dockerCompose() {
  local handler="_${FUNCNAME[0]}"

  local deployment="" aa=()
  local buildFlag=false deleteVolumes=false keepVolumes="" keepVolumesDefault=false hasCommand=false debugFlag=false
  local databaseVolume="" requiredEnvironment=() requiredArguments=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --production)
      deployment="production"
      ;;
    --staging)
      deployment="staging"
      ;;
    --deployment)
      shift
      deployment="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      deployment="$(uppercase "$deployment")"
      ! $debugFlag || decorate info "Deployment set to $deployment"
      ;;
    --volume)
      shift
      databaseVolume=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --clean)
      deleteVolumes=true
      ;;
    --keep)
      deleteVolumes=false
      keepVolumes=true
      ;;
    --build)
      buildFlag=true
      hasCommand=true
      ;;
    --arg | --default-env | --env)
      local environmentPair
      shift
      environmentPair="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      local name="${environmentPair%%=*}" value="${environmentPair#*=}"
      ! $debugFlag || decorate info "Environment supplied $(decorate pair "$name" "$value")"
      name="$(usageArgumentEnvironmentVariable "$handler" "$argument" "$name")" || return $?
      if [ "$argument" = "--arg" ]; then
        requiredArguments+=("$name" "$value")
      else
        requiredEnvironment+=("$name" "$value")
      fi
      ;;
    db)
      aa+=("$argument")
      keepVolumesDefault=false
      ;;
    web)
      keepVolumesDefault=true
      aa+=("$argument")
      ;;
    *)
      if isDockerComposeCommand "$argument"; then
        aa+=("$@")
        hasCommand=true
        break
      fi
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$deployment" ] || deployment="staging"
  [ -n "$keepVolumes" ] || keepVolumes=$keepVolumesDefault

  if [ -z "$databaseVolume" ]; then
    local home dockerName

    home=$(catchReturn "$handler" buildHome) || return $?
    dockerName=$(basename "$home")

    databaseVolume="${dockerName}_database_data"
  fi

  local start home

  start=$(timingStart)

  if ! $buildFlag && ! $hasCommand; then
    throwArgument "$handler" "Need a docker command:"$'\n'"- $(dockerComposeCommandList | decorate each code)" || return $?
  fi

  __dockerComposeEnvironmentSetup "$handler" "$deployment" "${requiredEnvironment[@]+"${requiredEnvironment[@]}"}" DEPLOYMENT "$deployment" || return $?

  local argument
  [ "${#requiredArguments[@]}" -eq 0 ] || while read -r argument; do aa+=("$argument"); done < <(__dockerComposeArgumentSetup "$handler" "${requiredArguments[@]}") || return $?

  if $buildFlag; then
    aa=("${aa[@]+"${aa[@]}"}" "build")
    if $deleteVolumes; then
      ! $debugFlag || decorate info "--clean supplied so deleting volumes"
      if dockerVolumeExists "$databaseVolume"; then
        ! $debugFlag || decorate info "$databaseVolume volume exists, deleting"
        __dockerVolumeDelete "$handler" "$databaseVolume" || return $?
        statusMessage decorate warning "Deleted volume $(decorate code "${databaseVolume}") - will be created with new environment variables"
      else
        decorate info "Volume $(decorate code "$databaseVolume") does not exist"
      fi
    elif $keepVolumes; then
      ! $debugFlag || decorate info "--keep supplied, no deletion"
      if dockerVolumeExists "$databaseVolume"; then
        decorate info "Keeping volume $(decorate code "$databaseVolume")"
      fi
    else
      __dockerVolumeDeleteInteractive "$handler" "$databaseVolume" || return $?
    fi
  fi

  ! $debugFlag || decorate info "Running" "$(decorate label "docker compose")" "$(decorate each code "${aa[@]+"${aa[@]}"}")"
  __dockerCompose "$handler" "${aa[@]+"${aa[@]}"}" || return $?

  local name
  name="$(decorate label "$(buildEnvironmentGet APPLICATION_NAME)")"
  statusMessage --last timingReport "$start" "Completed $name in"
}
_dockerCompose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__dockerCompose() {
  local handler="$1" home && shift
  home=$(catchReturn "$handler" buildHome) || return $?
  [ -f "$home/docker-compose.yml" ] || throwEnvironment "$handler" "Missing $(decorate file "$home/docker-compose.yml")" || return $?
  COMPOSE_BAKE=true docker compose -f "$home/docker-compose.yml" "$@"
}

# Uppercase deployment name for environment file
#
# DEPLOYMENT=staging matches .STAGING.env
# DEPLOYMENT=production matches .PRODUCTION.env
# DEPLOYMENT=test matches .TEST.env
# The env file must exist locally or fails
__dockerComposeEnvironmentSetup() {
  local handler="$1" deployment="$2" && shift 2

  local home deploymentEnv envFile
  home=$(catchReturn "$handler" buildHome) || return $?

  deploymentEnv=".$(uppercase "$deployment").env"
  [ -f "$home/$deploymentEnv" ] || throwEnvironment "$handler" "Missing $deploymentEnv" || return $?

  envFile="$home/.env"
  if [ -f "$envFile" ]; then
    local checkEnv
    while read -r checkEnv; do
      if muzzle diff -q "$envFile" "$checkEnv"; then
        catchEnvironment "$handler" rm -rf "$envFile" || return $?
        break
      fi
    done < <(find "$home" -maxdepth 1 -name ".*.env")
  fi
  if [ -f "$envFile" ]; then
    statusMessage decorate warning "Backing up $(decorate file "$envFile") ..."
    catchEnvironment "$handler" cp "$envFile" "$home/.$(date '+%F_%T').env" || return $?
  fi
  catchEnvironment "$handler" cp "$deploymentEnv" "$envFile" || return $?

  printf "%s\n" "" "# Added values" >>"$envFile"
  local icon="⬅"
  # Remaining arguments are pairs
  while [ $# -gt 1 ]; do
    local variable="$1" value="$2" envValue

    envValue=$(environmentValueRead "$envFile" "$variable") || :
    if [ -z "$envValue" ]; then
      decorate info "Writing $(decorate file "$envFile") $icon $(decorate code "$variable") $(decorate value "$value") (default)"
      catchReturn "$handler" environmentValueWrite "$variable" "$value" >>"$envFile" || return $?
    fi
    shift 2
  done
}

# Uppercase deployment name for environment file
#
# DEPLOYMENT=staging matches .STAGING.env
# DEPLOYMENT=production matches .PRODUCTION.env
# DEPLOYMENT=test matches .TEST.env
# The env file must exist locally or fails
__dockerComposeArgumentSetup() {
  local handler="$1" && shift

  local home deploymentEnv envFile
  home=$(catchReturn "$handler" buildHome) || return $?

  envFile="$home/.env"
  local icon="⬅"
  # Remaining arguments are pairs
  while [ $# -gt 1 ]; do
    local variable="$1" value="$2" envValue

    envValue=$(environmentValueRead "$envFile" "$variable") || :
    if [ -z "$envValue" ]; then
      throwArgument "$handler" "$envFile does not have a variable $variable" || return $?
    fi
    printf "%s\n" "--build-arg" "$variable=$envValue"
    shift 2
  done
}
