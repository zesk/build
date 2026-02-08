#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: testsuite-start

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../tools.sh"; then

  # fn: hookRun testsuite-start
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestSuiteStart() {
    local handler="_${FUNCNAME[0]}"

    local home && home=$(catchReturn "$handler" buildHome) || return $?

    local junitTemp="" stateFile="" suiteName=""

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

    local junitTemp && junitTemp=$(environmentValueRead "$stateFile" junitTemp) || return $?

    if [ -d "$junitTemp" ]; then
      catchReturn "$handler" muzzle directoryRequire "$junitTemp/$suiteName" || return $?
      catchReturn "$handler" environmentValueWrite junitSuiteTemp "$junitTemp/$suiteName" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite timestampSuite "$(date "+%FT%T")" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite startSuite "$(timingStart)" >>"$stateFile" || return $?
      if [ -n "${TEST_FILE-}" ]; then
        catchReturn "$handler" environmentValueWrite testFile "$TEST_FILE" >>"$stateFile" || return $?
      fi
    fi

    # Run next hook as well
    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "$@" || return $?
  }

  ___hookTestSuiteStart() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestSuiteStart "$@"
fi
