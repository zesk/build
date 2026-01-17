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

  # IDENTICAL profileFunctionHead 6
  # ********************************************************************************************************************
  local __profile=false __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "

  if [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  false || muzzle identicalCheck || return $?
  sleep 1

  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != false ]; then __profileNext="$(timingStart)" && printf "%s%d %s\n" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

  # IDENTICAL profileFunctionMarkerOthers 3
  # ********************************************************************************************************************
  if [ "$__profile" != false ]; then __profileNext="$(timingStart)" && __profileUsed=$((__profileUsed + (__profileNext - __profile))) && printf "%s%d %s (*them %d)\n" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" "$__profileUsed" && __profile=$__profileNext; fi

  # IDENTICAL profileFunctionTail 7
  # ********************************************************************************************************************
  if [ "$__profile" != false ]; then
    __profileNext="$(timingStart)" && printf "%s%d %s\n" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel"
    printf -- "%s%d %s (%d + %d) %s + %s %d%%\n" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))"
  fi
  # ********************************************************************************************************************

  return $exitCode
}
