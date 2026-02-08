#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: test-start

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../tools.sh"; then

  # fn: hookRun test-start
  # Summary: Run when a test is started (before running)
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
          suiteName=$(validate "$handler" String "$argument") || return $?
        elif [ -z "$testName" ]; then
          testName=$(validate "$handler" String "$argument") || return $?
        elif [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$suiteName" ] || throwArgument "$handler" "suiteName is required" || return $?
    [ -n "$testName" ] || throwArgument "$handler" "testName is required" || return $?
    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?

    local returnCode=0 && (
      local junitSuiteTemp=""
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -d "$junitSuiteTemp" ]; then
        catchReturn "$handler" printf "%s\n" "$testName" >>"$junitSuiteTemp/skipped" || return $?
      fi
    ) || returnCode=$?
    local home && home=$(catchReturn "$handler" buildHome) || return $?
    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "$@" || return $?
    return "$returnCode"
  }
  ___hookTestSkip() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestSkip "$@"
fi
