#!/usr/bin/env bash
#
# Stats
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: test-stop

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun test-stop
  # Summary: Run when a test is finished (after running)
  __hookTestStop() {
    local handler="_${FUNCNAME[0]}"

    local suiteName="" testName="" stateFile="" failedMessage=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --failed) shift && failedMessage="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
      *)
        if [ -z "$suiteName" ]; then
          suiteName=$(validate "$handler" String "suiteName" "$argument") || return $?
        elif [ -z "$testName" ]; then
          testName=$(validate "$handler" String "testName" "$argument") || return $?
        elif [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$suiteName" ] || throwArgument "$handler" "suiteName is required" || return $?
    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?
    [ -n "$testName" ] || throwArgument "$handler" "testName is required" || return $?

    local returnCode=0 && (
      local statsTempPath="" statsAssertStatistics=() passed=${TEST_SUCCESS-false}
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -f "$statsTempPath" ]; then
        local segment=() ss=() && read -r -a ss < <(assertStatistics) || return $?
        local i && for i in "${!ss[@]}"; do
          segment[i]=$((ss[i] - statsAssertStatistics[i]))
        done
        catchReturn "$handler" environmentValueWriteArray statsAssertStatistics "${ss[@]}" >>"$stateFile" || return $?
        [ -z "$failedMessage" ] || passed=false
        local suffix="" && $passed || suffix=" (FAILED)"
        printf "%d %s%s\n" $(($(timingStart) - ${TEST_START-0})) "$(printf "%d " "${segment[@]}")" "$testName $suffix" >>"$statsTempPath"
      fi
    ) || returnCode=$?

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?

    return "$returnCode"
  }
  ___hookTestStop() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestStop "$@"
fi
