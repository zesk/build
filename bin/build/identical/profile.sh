#!/usr/bin/env bash
#
# profile.sh
#
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.

__testFunction() {
  local __count=$# __saved=("$@") exitCode=0
  # ********************************************************************************************************************
  # Configure your profiling flags as desired using whatever global needed
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  # IDENTICAL profileFunctionEnable 3
  # ********************************************************************************************************************
  if [ "$__profile" = "false" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  false || muzzle identicalCheck || return $?
  sleep 1

  __profileLabel="describe what happened between this and prior profile call"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  __profileLabel="describe what happened between this and prior profile call"
  # IDENTICAL profileFunctionMarkerOthers 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && __profileUsed=$((__profileUsed + (__profileNext - __profile))) && printf "Line %d: %s%d %s (*them %d)\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" "$__profileUsed" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  __profileLabel="describe what happened between this and prior profile call"
  # IDENTICAL profileFunctionTail 6
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then
    __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
    printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
  fi
  # ********************************************************************************************************************

  return $exitCode
}
