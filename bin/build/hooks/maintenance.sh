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
  local envFile=.env.local
  local variable=$1 value=$2
  if [ ! -f "$envFile" ]; then
    touch "$envFile"
    printf "%s %s %s\n" "$(decorate warning "Created")" "$(decorate code "$envFile")" "$(decorate warning "(maintenance - did not exist)")" 1>&2
  fi
  grep -v "$variable" "$envFile" >"$envFile.$$" || :
  printf "%s=%s\n" "$variable" "$value" >>"$envFile.$$" || _environment "writing temp $envFile" || return $?
  __environment mv -f "$envFile.$$" "$envFile" || return $?
}

# fn: {base}
# Usage: {fn} [ --message message ] maintenanceSetting
# Argument: message - Required. String. Maintenance setting: `on | 1 | true | off | 0 | false`
# Argument: maintenanceSetting - Required. String. Maintenance setting: `on | 1 | true | off | 0 | false`
# Toggle maintenance on or off. The default version of this modifies
# the environment files for the application by modifying the `.env.local` file
# and dynamically adding or removing any line which matches the MAINTENANCE variable.
#
# Environment: BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.
#
__hookMaintenance() {
  local enable message variable messageVariable messageColor messageValue maintenanceValue
  local handler="_${FUNCNAME[0]}"

  export BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE

  __catch "$handler" buildEnvironmentLoad BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE || return $?

  variable=${BUILD_MAINTENANCE_VARIABLE-}
  messageVariable=${BUILD_MAINTENANCE_MESSAGE_VARIABLE-}

  [ -n "$variable" ] || __throwEnvironment "$handler" "BUILD_MAINTENANCE_VARIABLE is blank, no default behavior" || return $?
  message=
  enable=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
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
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
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
  fi
  __hookMaintenanceSetValue "$variable" "$maintenanceValue" || __throwEnvironment "$handler" "Unable to set $variable to $maintenanceValue" || return $?
  __hookMaintenanceSetValue "$messageVariable" "$message" || decorate warning "Maintenance message not set, continuing with errors"
  printf "%s %s - %s\n" "$(decorate "$messageColor" "Maintenance")" "$messageValue" "$messageSuffix"
}
___hookMaintenance() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__hookMaintenance "$@"
