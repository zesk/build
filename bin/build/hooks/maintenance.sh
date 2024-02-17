#!/usr/bin/env bash
#
# Maintenance hook for an application
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

envFile=.env.local

setMaintenanceValue() {
  local variable=$1 value=$2
  if [ ! -f "$envFile" ]; then
    touch "$envFile"
    printf "%s %s %s\n" "$(consoleWarning "Created")" "$(consoleCode "$envFile")" "$(consoleWarning "(maintenance - did not exist)")" 1>&2
  fi
  grep -v "$variable" "$envFile" >"$envFile.$$" || :
  if ! printf "%s=%s\n" "$variable" "$value" >>"$envFile.$$" || ! mv -f "$envFile.$$" "$envFile"; then
    return "$errorEnvironment"
  fi
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
  local enable message variable messageVariable messageColor messageValue maintenanceValue

  export BUILD_MAINTENANCE_VARIABLE BUILD_MAINTENANCE_MESSAGE_VARIABLE

  # shellcheck source=/dev/null
  if ! source ./bin/build/env/BUILD_MAINTENANCE_VARIABLE.sh; then
    _hookMaintenance "$errorEnvironment" "BUILD_MAINTENANCE_VARIABLE.sh failed" || return $?
  fi
  # shellcheck source=/dev/null
  if ! source ./bin/build/env/BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh; then
    _hookMaintenance "$errorEnvironment" "BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh failed" || return $?
  fi

  variable=${BUILD_MAINTENANCE_VARIABLE-}
  messageVariable=${BUILD_MAINTENANCE_MESSAGE_VARIABLE-}

  if [ -z "$variable" ]; then
    _hookMaintenance "$errorEnvironment" "BUILD_MAINTENANCE_VARIABLE is blank, no default behavior" || return $?
  fi
  message=
  enable=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _hookMaintenance "$errorArgument" "Blank argument" || return $?
    fi
    case "$(lowercase "$1")" in
      on | 1 | true | enable)
        enable=1
        ;;
      off | 0 | false | disabled)
        enable=
        ;;
      --message)
        shift || :
        if [ -z "$messageVariable" ]; then
          consoleWarning "--message is a no-op with blank BUILD_MAINTENANCE_MESSAGE_VARIABLE"
        fi
        message="$1"
        ;;
      *)
        usage "$errorArgument" "Unknown argument $1" || return $?
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
  if ! setMaintenanceValue "$variable" "$maintenanceValue"; then
    _hookMaintenance "$errorEnvironment" "Unable to set $variable to $maintenanceValue" || return $?
  fi
  if ! setMaintenanceValue "$messageVariable" "$message"; then
    consoleWarning "Maintenance message not set, continuing with errors"
  fi
  printf "%s %s - %s\n" "$("$messageColor" "Maintenance")" "$messageValue" "$messageSuffix"
}
_hookMaintenance() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookMaintenance "$@"
