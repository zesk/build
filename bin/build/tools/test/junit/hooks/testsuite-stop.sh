#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: testsuite-stop

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun testsuite-stop
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestSuiteStop() {
    local handler="_${FUNCNAME[0]}"

    local suiteName="" stateFile=""

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
        elif [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$suiteName" ] || throwArgument "$handler" "suiteName is required" || return $?
    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?

    local suiteName="$TEST_SUITE_NAME"
    local returnCode=0 && (
      local junitTemp="" tests=0 failures=0 errors=0 skipped=0 testFile="" junitSuiteTemp="" startSuite=0 junitKeepTemp=false timestampSuite=""
      __testLoader "$handler" : || return $?
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -d "$junitSuiteTemp" ]; then
        local suiteXML="$junitTemp/.suiteXML/$suiteName.xml" suiteStats="$junitTemp/$suiteName.stats"

        __collectStats "$handler" "$junitSuiteTemp" tests success failures errors skipped >"$suiteStats" || return $?
        catchReturn "$handler" source "$suiteStats" || return $?
        __mergeStats "$handler" "$junitSuiteTemp" "$junitTemp/.totals/" tests success failures errors skipped || return $?
        $junitKeepTemp || catchReturn "$handler" rm -f "$suiteStats" || return $?

        {
          local aa=(
            "name=$suiteName"
            "tests=$tests"
            "failures=$failures"
            "errors=$errors"
            "skipped=$skipped"
            "time=$(timingFormat "$(timingElapsed "$startSuite")")"
            "file=$testFile"
            "timestamp=$timestampSuite"
          )
          catchReturn "$handler" junitSuiteOpen "${aa[@]}" || return $?
          catchReturn "$handler" find "$junitSuiteTemp" -type f -name '*.xml' | sort -u | xargs cat || return $?
          catchReturn "$handler" junitSuiteClose || return $?
        } >>"$suiteXML" || return $?
        $junitKeepTemp || catchReturn "$handler" rm -rf "$junitSuiteTemp" || return $?
        catchReturn "$handler" environmentValueWrite junitSuiteTemp "" >>"$stateFile" || return $?
      fi
    ) || returnCode=$?

    # IDENTICAL hookRunOptionalNext 2
    local home && home=$(catchReturn "$handler" buildHome) || return $?
    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?

    return "$returnCode"
  }
  ___hookTestSuiteStop() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestSuiteStop "$@"
fi
