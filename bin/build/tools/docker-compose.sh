#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/docker-compose.md
# Test: ./test/tools/docker-compose-tests.sh

# Is docker compose currently running?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 1 - Not running
# Exit Code: 0 - Running
dockerComposeIsRunning() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
  local temp
  temp=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" dockerCompose ps --format json >"$temp" || _clean $? "$temp" || return $?
  local exitCode=1
  isEmptyFile "$temp" || exitCode=0
  __catchEnvironment "$usage" rm -rf "$temp" || return $?
  return $exitCode
}
_dockerComposeIsRunning() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List of docker compose commands
# Updated: 2025-04-07
# Require-Update: 90
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dockerComposeCommandList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  # Sampled 2025
  printf -- "%s\n" attach build commit config cp create down events exec export images kill logs ls pause port ps pull push restart rm run scale start stats stop top unpause up version wait watch | sort -u
}
_dockerComposeCommandList() {
  ! false || dockerComposeCommandList --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is this a docker compose command?
# Argument: command - String. Required. The command to test.
# See: dockerComposeCommandList
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - Yes, it is.
# Exit Code: 1 - No, it is not.
isDockerComposeCommand() {
  local usage="_${FUNCNAME[0]}" command="${1-}"

  [ -n "$command" ] || __throwArgument "$usage" "command is blank" || return $?
  if [ "$command" = "--help" ]; then
    "$usage" 0
    return $?
  fi
  grep -q -e "$(quoteGrepPattern "$command")" < <(dockerComposeCommandList)
}
_isDockerComposeCommand() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# docker compose wrapper with automatic .env support
#
# Argument: --production - Flag. Production container build. Shortcut for `--deployment production` (uses `.PRODUCTION.env`)
# Argument: --staging - Flag. Staging container build. Shortcut for `--deployment staging` (uses `.STAGING.env`)
# Argument: --deployment deploymentName - String. Deployment name to use. (uses `.$(uppercase "$deploymentName").env`)
# Argument: --volume - String. Name of the volume associated with the container to preserve or delete.
# Argument: --build - Flag. `build` command with volume management
# Argument: --clean - Flag. Delete the volume prior to building.
# Argument: --keep - Flag. Keep the volume during build.
# Argument: --default-env | --env environmentNameValue - EnvironmentNameValue. An environment variable name and value (in the form `NAME=value` to require in the `.env` file.
# Argument: --env environmentNameValue - EnvironmentNameValue. An environment variable name and value (in the form `NAME=value` to require in the `.env` file. If set already in the file or in the environment then has no effect.
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
  local usage="_${FUNCNAME[0]}"

  local deployment="" aa=()
  local buildFlag=false deleteVolumes=false keepVolumes="" keepVolumesDefault=false hasCommand=false debugFlag=false
  local databaseVolume=""

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
        deployment="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        deployment="$(uppercase "$deployment")"
        ! $debugFlag || decorate info "Deployment set to $deployment"
        ;;
      --volume)
        shift
        databaseVolume=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
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
      --default-env | --env)
        local environmentPair
        shift
        environmentPair="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        local name="${environmentPair%%=*}" value="${environmentPair#*=}"
        ! $debugFlag || decorate info "Environment supplied $(decorate pair "$name" "$value")"
        name="$(usageArgumentEnvironmentVariable "$usage" "$argument" "$name")" || return $?
        requiredEnvironment+=("$name" "$value")
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$deployment" ] || deployment="staging"
  [ -n "$keepVolumes" ] || keepVolumes=$keepVolumesDefault

  if [ -z "$databaseVolume" ]; then
    local home dockerName

    home=$(__catchEnvironment "$usage" buildHome) || return $?
    dockerName=$(basename "$home")

    databaseVolume="${dockerName}_database_data"
  fi

  local start home

  start=$(timingStart)

  if ! $buildFlag && ! $hasCommand; then
    __throwArgument "$usage" "Need a docker command:"$'\n'"- $(dockerComposeCommandList | decorate each code)" || return $?
  fi

  __dockerComposeEnvironmentSetup "$usage" "$deployment" "${requiredEnvironment[@]+"${requiredEnvironment[@]}"}" DEPLOYMENT="$deployment" || return $?

  if $buildFlag; then
    aa=("build" "${aa[@]+"${aa[@]}"}")
    if $deleteVolumes; then
      ! $debugFlag || decorate info "--clean supplied so deleting volumes"
      if dockerVolumeExists "$databaseVolume"; then
        ! $debugFlag || decorate info "$databaseVolume volume exists, deleting"
        __dockerVolumeDelete "$usage" "$databaseVolume" || return $?
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
      __dockerVolumeDeleteInteractive "$usage" "$databaseVolume" || return $?
    fi
  fi

  ! $debugFlag || decorate info "Running" "$(decorate label "docker compose")" "$(decorate each code "${aa[@]+"${aa[@]}"}")"
  __dockerCompose "$usage" "${aa[@]+"${aa[@]}"}" || return $?

  local name
  name="$(decorate label "$(buildEnvironmentGet APPLICATION_NAME)")"
  statusMessage --last timingReport "$start" "Completed $name in"
}
_dockerCompose() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__dockerCompose() {
  local usage="$1" home && shift
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  [ -f "$home/docker-compose.yml" ] || __throwEnvironment "$usage" "Missing $(decorate file "$home/docker-compose.yml")" || return $?
  COMPOSE_BAKE=true docker compose -f "$home/docker-compose.yml" "$@"
}

# Uppercase deployment name for environment file
#
# DEPLOYMENT=staging matches .STAGING.env
# DEPLOYMENT=production matches .PRODUCTION.env
# DEPLOYMENT=test matches .TEST.env
# The env file must exist locally or fails
__dockerComposeEnvironmentSetup() {
  local usage="$1" deployment="$2" && shift 2

  local home deploymentEnv envFile
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  deploymentEnv=".$(uppercase "$deployment").env"
  [ -f "$home/$deploymentEnv" ] || __throwEnvironment "$usage" "Missing $deploymentEnv" || return $?

  envFile="$home/.env"
  if [ -f "$envFile" ]; then
    local checkEnv
    while read -r checkEnv; do
      if muzzle diff -q "$envFile" "$checkEnv"; then
        __catchEnvironment "$usage" rm -rf "$envFile" || return $?
        break
      fi
    done < <(find "$home" -maxdepth 1 -name ".*.env")
  fi
  if [ -f "$envFile" ]; then
    statusMessage decorate warning "Backing up $(decorate file "$envFile") ..."
    __catchEnvironment "$usage" cp "$envFile" "$home/.$(date '+%F_%T').env" || return $?
  fi
  __catchEnvironment "$usage" cp "$deploymentEnv" "$envFile" || return $?

  # Remaining arguments are pairs
  while [ $# -gt 1 ]; do
    local variable="$1" value="$2" envValue

    envValue=$(environmentValueRead "$envFile" "$variable") || :
    if [ -z "$envValue" ]; then
      decorate info "Writing default $(decorate code "$variable") $(decorate value "$value") to $(decorate file "$envFile")"
      __catchEnvironment "$usage" environmentValueWrite "$variable" "$value" >>"$envFile" || return $?
    fi
    shift 2
  done
}
