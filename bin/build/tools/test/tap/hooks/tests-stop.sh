#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-stop

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun tests-stop
  # Summary: Run when a tests are finalized (after test running is terminated)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestsStop() {
    local handler="_${FUNCNAME[0]}"

    local stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --terminate) shift && terminateReason=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
      *)
        if [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?

    (
      local tapTemp="" tapPath=""
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -d "$tapTemp" ]; then
        [ -z "$terminateReason" ] || catchReturn "$handler" __testSuiteTAP_bail "$terminateReason" >>"$tapPath" || return $?
        catchReturn "$handler" rm -rf "$tapTemp" || return $?
        catchReturn "$handler" environmentValueWrite "tapTemp" "" >>"$stateFile" || return $?
      fi
    ) || return $?

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookTestsStop() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsStop "$@"
fi
