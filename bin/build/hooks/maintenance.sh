#!/usr/bin/env bash
#
# Maintenance hook for an application
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../tools.sh" || exit 1

envFile=.env.local

setMaintenanceValue() {
  local variable=$1 value=$2
  if [ ! -f "$envFile" ]; then
    touch "$envFile"
    printf "%s %s %s\n" "$(consoleWarning "Created")" "$(consoleCode "$envFile")" "$(consoleWarning "(maintenance - did not exist)")" 1>&2
  fi
  grep -v "$variable" "$envFile" >"$envFile.$$" || :
  printf "%s=%s\n" "$variable" "$value" >>"$envFile.$$" || _environment "writing temp $envFile" || return $?
  __environment mv -f "$envFile.$$" "$envFile" || return $?
}

#
# fn: {base} [ --message message ] maintenanceSetting
# Argument: message - Required. String. Maintenance setting: `on | 1 | true | off 0 | false`
# Argument: maintenanceSetting - Required. String. Maintenance setting: `on | 1 | true | off 0 | false`
# Toggle maintenance on or off. The default version of this modifies
# the environment files for the application by modifying the `.env.local` file
# and dynamically adding or removing any line which matches the MAINTENANCE variable.
#
# Environment: BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.
#
hookMaintenance() {
  local argument enable message variable messageVariable messageColor messageValue maintenanceValue
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  export BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE || return $?

  variable=${BUILD_MAINTENANCE_VARIABLE-}
  messageVariable=${BUILD_MAINTENANCE_MESSAGE_VARIABLE-}

  [ -n "$variable" ] || __failEnvironment "$usage" "BUILD_MAINTENANCE_VARIABLE is blank, no default behavior" || return $?
  message=
  enable=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$(lowercase "$argument")" in
      on | 1 | true | enable)
        enable=true
        ;;
      off | 0 | false | disabled)
        enable=false
        ;;
      --message)
        shift || :
        if [ -z "$messageVariable" ]; then
          consoleWarning "--message is a no-op with blank BUILD_MAINTENANCE_MESSAGE_VARIABLE"
        fi
        message="$1"
        ;;
      *)
        __failArgument "$usage" "Unknown argument $argument" || return $?
        ;;
    esac
    shift
  done
  if test "$enable"; then
    messageColor=consoleSuccess
    maintenanceValue=1
    messageValue=$(consoleCode "[ ON ]")
    messageSuffix=$(consoleBoldRed "currently in maintenance mode")
  else
    messageColor=consoleSuccess
    messageValue=$(consoleBoldGreen "off")
    maintenanceValue=
    messageSuffix=$(consoleBoldMagenta "Now LIVE")
  fi
  setMaintenanceValue "$variable" "$maintenanceValue" || __failEnvironment "$usage" "Unable to set $variable to $maintenanceValue" || return $?
  setMaintenanceValue "$messageVariable" "$message" || consoleWarning "Maintenance message not set, continuing with errors"
  printf "%s %s - %s\n" "$("$messageColor" "Maintenance")" "$messageValue" "$messageSuffix"
}
_hookMaintenance() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookMaintenance "$@"
