#!/usr/bin/env bash
#
# Maintenance hook for an application
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

__hookMaintenanceSetValue() {
  local handler="$1" envFile="$2" variable="$3" value="$4"
  local tempEnvFile="$envFile.$$"
  if [ ! -f "$envFile" ]; then
    catchReturn "$handler" environmentValueWrite "BUILD_MAINTENANCE_CREATED_FILE" "true" >>"$tempEnvFile" || returnClean $? "$tempEnvFile" || return $?
    printf "%s %s %s\n" "$(decorate warning "Created")" "$(decorate code "$envFile")" "$(decorate warning "(maintenance - did not exist)")" 1>&2
  else
    grep -v "$variable" "$envFile" >"$tempEnvFile" || :
  fi
  catchReturn "$handler" environmentValueWrite "$variable" "$value" >>"$envFile.$$" || returnClean $? "$tempEnvFile" || return $?
  catchEnvironment "$handler" mv -f "$tempEnvFile" "$envFile" || returnClean $? "$tempEnvFile" || return $?
}

# fn: hookRun maintenance
# Argument: maintenanceSetting - Required. String. Maintenance setting: `on | 1 | true | enable | off | 0 | false | disable`
# Argument: --message maintenanceMessage - Optional. String. Message to display to the use as to why maintenance is enabled.
# Toggle maintenance on or off. The default version of this modifies the environment files for the application by modifying the `.env.local` file
# and dynamically adding or removing any line which matches the MAINTENANCE variable.
#
# Note that applications SHOULD load this configuration file dynamically (and monitor it for changes) to enable maintenance at any time.
#
# Environment: BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.
#
__hookMaintenance() {
  local variable messageVariable
  local handler="_${FUNCNAME[0]}"

  home=$(catchReturn "$handler" buildHome) || return $?
  export BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE

  catchReturn "$handler" buildEnvironmentLoad BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE || return $?

  variable=${BUILD_MAINTENANCE_VARIABLE-}
  messageVariable=${BUILD_MAINTENANCE_MESSAGE_VARIABLE-}

  [ -n "$variable" ] || throwEnvironment "$handler" "BUILD_MAINTENANCE_VARIABLE is blank, no default behavior" || return $?
  local message="" enable=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    on | 1 | true | enable)
      enable=true
      ;;
    off | 0 | false | disabled)
      enable=false
      ;;
    --message)
      shift || :
      if [ -z "$messageVariable" ]; then
        decorate warning "--message is a no-op with blank BUILD_MAINTENANCE_MESSAGE_VARIABLE"
      fi
      message="$1"
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  local envFile="$home/.env.local"

  local messageColor messageValue maintenanceValue deleteFile=false
  if "$enable"; then
    messageColor=success
    maintenanceValue=1
    messageValue=$(decorate code "[ ON ]")
    messageSuffix=$(decorate bold-red "(maintenance mode)")
  else
    messageColor=info
    messageValue=$(decorate bold-green "- off -")
    maintenanceValue=
    messageSuffix=$(decorate bold-magenta "NOW LIVE!")
    if [ -f "$envFile" ]; then
      deleteFile=$(catchReturn "$handler" environmentValueRead "$envFile" BUILD_MAINTENANCE_CREATED_FILE false) || return $?
      if [ -z "$deleteFile" ]; then
        deleteFile=false
        messageSuffix="$messageSuffix deleteFile is blank"
      else
        messageSuffix="$messageSuffix deleteFile=$deleteFile"
      fi
    else
      messageSuffix="No env.local - nothing to do to disable"
    fi
  fi
  if [ -f "$envFile" ]; then
    if $deleteFile; then
      catchEnvironment "$handler" rm -f "$envFile" || return $?
    else
      __hookMaintenanceSetValue "$handler" "$envFile" "$variable" "$maintenanceValue" || return $?
      __hookMaintenanceSetValue "$handler" "$envFile" "$messageVariable" "$message" || return $?
    fi
  fi
  printf "%s %s - %s\n" "$(decorate "$messageColor" "Maintenance")" "$messageValue" "$messageSuffix"
}
___hookMaintenance() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookMaintenance "$@"
