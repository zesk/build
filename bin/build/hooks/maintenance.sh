#!/usr/bin/env bash
#
# Maintenance hook for an application
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

envFile=.env.local
variable=${BUILD_MAINTENANCE_VARIABLE-MAINTENANCE}
onValue=${BUILD_MAINTENANCE_ON_VALUE-1}
offValue=${BUILD_MAINTENANCE_OFF_VALUE-}

setMaintenanceValue() {
  local variable=$1 value=$2
  if [ ! -f "$envFile" ]; then
    touch "$envFile"
    consoleWarning "Created $envFile"
  fi
  set -x
  grep -v "$variable" "$envFile" >"$envFile.$$" || :
  printf "%s=%s\n" "$variable" "$value" >>"$envFile.$$"
  mv -f "$envFile.$$" "$envFile"
}

#
# fn: {base}
#
# Toggle maintenance on or off. The default version of this modifies
# the environment files for the application by modifying the `.env.local` file
# and dynamically adding or removing any line which matches the MAINTENANCE variable.
#
# Environment: BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.
# Environment: BUILD_MAINTENANCE_ON_VALUE - If maintenance is on, the variable is set to this value. Defaults to `1`.
# Environment: BUILD_MAINTENANCE_OFF_VALUE - If maintenance is off, the variable is set to this value. Defaults to a blank string (`""`).
#
hookMaintenance() {
  local enable=

  while [ $# -gt 0 ]; do
    case "$(lowercase "$1")" in
      on | 1 | true | enable)
        enable=1
        ;;
      off | 0 | false | disabled)
        enable=
        ;;
      *)
        usage "$errorArgument" "Unknown argument $1"
        return $?
        ;;
    esac
    shift
  done
  if test "$enable"; then
    consoleSuccess "Maintenance on"
    setMaintenanceValue "$variable" "$onValue"
  else
    consoleWarning "Maintenance off"
    setMaintenanceValue "$variable" "$offValue"
  fi
}

hookMaintenance "$@"
