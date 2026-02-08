#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: testsuite-end

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../tools.sh"; then

  # fn: hookRun testsuite-end
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestSuiteStop() {
    local handler="_${FUNCNAME[0]}"

    local home && home=$(catchReturn "$handler" buildHome) || return $?

    local suiteName="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      *)
        if [ -z "$stateFile" ]; then
          suiteName=$(validate "$handler" String "$argument") || return $?
        elif [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$suiteName" ] || throwArgument "$handler" "suiteName is required" || return $?
    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?

    local returnCode=0 && (
      local undo=(rm -rf "$junitSuiteTemp")

      catchReturn "$handler" source "$stateFile" || returnUndo $? "${undo[@]}" || return $?
      if [ -d "$junitSuiteTemp" ]; then
        local suiteXML="$junitTemp/.xml/$suiteName.xml"
        local junitTemp="" suiteName="" tests=0 failures=0 errors=0 skipped=0 testFile="" junitSuiteTemp="" junitSuiteStart=0

        local suiteStats="$junitTemp/$suiteName.stats"

        __collectStats "$handler" "$junitSuiteTemp" tests failures errors skipped >"$suiteStats" || return $?
        catchReturn "$handler" source "$suiteStats" || return $?

        {
          local aa=(
            "name=$suiteName"
            "tests=$tests"
            "failures=$failures"
            "errors=$errors"
            "skipped=$skipped"
            "time=$(timingFormat "$(timingElapsed "$junitSuiteStart")")"
            "file=$testFile"
            "timestamp=$(dateFromTimestamp "$((junitSuiteStart / 1000))" "%FT%T")"
          )
          catchReturn "$handler" junitSuiteOpen "${aa[@]}" || returnUndo $? "${undo[@]}" || return $?
          catchReturn "$handler" find "$junitSuiteTemp" -type f | sort -u | xargs cat || returnUndo $? "${undo[@]}" || return $?
          catchReturn "$handler" junitSuiteClose || return $?
        } >>"$suiteXML" || returnUndo $? "${undo[@]}" || return $?
        catchReturn "$handler" rm -rf "$junitSuiteTemp" || return $?
        catchReturn "$handler" environmentValueWrite junitSuiteTemp "" >>"$stateFile" || return $?
      fi
    ) || returnCode=$?
    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "$@" || return $?
    return "$returnCode"
  }
  ___hookTestSuiteStop() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestSuiteEnd "$@"
fi
