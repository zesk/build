#!/usr/bin/env bash
#
# TAP
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: test-stop

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun test-stop
  # Summary: Run when a test is finished (after running)
  __hookTestSkip() {
    local handler="_${FUNCNAME[0]}"

    local suiteName="" testName="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
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
      local tapPath="" tapCachePath=""
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -f "$tapPath" ]; then
        __testLoader "$handler" :
        {
          if ! directive=$(__testSuiteTAP_ParseFlags "${TEST_FLAGS}"); then
            directive="$TEST_REASON"
          else
            directive=$(textTrim "$directive $TEST_REASON")
          fi
          catchReturn "$handler" __testSuiteTAP_skip "$tapCachePath" "$TEST_SUITE_NAME" "$TEST_NAME" "$TEST_FILE" "$TEST_LINE" "$directive" || return $?
        } >>"$tapPath" || return $?
      fi
    ) || returnCode=$?

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?

    return "$returnCode"
  }
  ___hookTestSkip() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestSkip "$@"
fi
