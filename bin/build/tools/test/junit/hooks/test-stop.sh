#!/usr/bin/env bash
#
# jUnit
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

    export TEST_SUCCESS

    [ -n "$suiteName" ] || throwArgument "$handler" "suiteName is required" || return $?
    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?
    [ -n "$testName" ] || throwArgument "$handler" "testName is required" || return $?

    local returnCode=0 && (
      local junitSuiteTemp="" testFile="-testFile-" stderr="" stdout="" error="" output
      local savedTestSuccess="${TEST_SUCCESS-}"
      local buildHomeRequired="-" plumber="-" housekeeper="-" testShouldFail="-"

      catchReturn "$handler" source "$stateFile" || return $?
      [ -z "$failedMessage" ] || TEST_SUCCESS=false

      if [ -d "$junitSuiteTemp" ]; then
        local target="$junitSuiteTemp/success"
        [ "${TEST_SUCCESS-}" = true ] || target="$junitSuiteTemp/failures"
        [ "${TEST_SKIPPED-}" != true ] || target="$junitSuiteTemp/skipped"
        catchReturn "$handler" printf "%s\n" "$testName" >>"$target" || return $?

        local testCaseXML="$junitSuiteTemp/$testName.xml"
        {
          junitTestCaseOpen name="$testName" file="$testFile" "assertions=${TEST_ASSERTIONS-0}" "elapsed=${TEST_ELAPSED-}"
          junitProperties testShouldFail=$testShouldFail plumber=$plumber housekeeper=$housekeeper buildHomeRequired=$buildHomeRequired "returnCode=${TEST_RETURN_CODE-}" "reason=${TEST_REASON-}" "success=${TEST_SUCCESS-}" "savedSuccess=$savedTestSuccess" skipped="${TEST_SKIPPED-}"
          if [ -n "$failedMessage" ]; then
            junitTestCaseFailureOpen "$failedMessage"
            [ ! -f "$stdout" ] || consoleToPlain <"$stdout" | __xmlContent
            [ ! -f "$stderr" ] || consoleToPlain <"$stderr" | __xmlContent | printfOutputPrefix "%s\n" "[stderr]:"
            [ ! -f "$error" ] || consoleToPlain <"$error" | __xmlContent | printfOutputPrefix "%s\n" "[error]:"
            [ ! -f "$output" ] || consoleToPlain <"$output" | __xmlContent | printfOutputPrefix "%s\n" "[output]:"
            junitTestCaseFailureClose
          fi
          if "${TEST_SKIPPED-false}"; then
            junitTestCaseSkipped "$TEST_REASON"
          fi
          if [ -f "$error" ]; then
            junitTestCaseErrorOpen
            consoleToPlain <"$error" | __xmlContent
            junitTestCaseErrorClose
          fi
          if [ -f "$stdout" ] || [ -f "$output" ]; then
            junitSystemOutputOpen
            [ ! -f "$output" ] || consoleToPlain <"$output" | __xmlContent | printfOutputPrefix "%s\n" "[output]:"
            [ ! -f "$stdout" ] || consoleToPlain <"$stdout" | __xmlContent | printfOutputPrefix "%s\n" "[stdout]:"
            junitSystemOutputClose
          fi
          if [ -f "$stderr" ]; then
            junitSystemErrorOpen
            consoleToPlain <"$stderr" | __xmlContent
            junitSystemErrorClose
          fi
          junitTestCaseClose
        } >"$testCaseXML"
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
