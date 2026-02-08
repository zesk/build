#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-finalize

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../tools.sh"; then

  # fn: hookRun tests-finalize
  # Summary: Run when a tests are finalized (after test running is terminated)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestsFinalize() {
    local handler="_${FUNCNAME[0]}"

    local home && home=$(catchReturn "$handler" buildHome) || return $?

    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "$@" || return $?

    local junitPath="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      *)
        if [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?

    if ! junitPath="$(environmentValueRead "$stateFile" junitPath)" || [ -z "$junitPath" ]; then
      return 0
    fi

    (
      # local flags="" __count="" __saved=""
      local undo=(rm -rf "$junitTemp")
      local tests=0 failures=0 errors=0 skipped=0 assertions=0 elapsed=0 timestamp="none" junitTemp=""
      catchReturn "$handler" source "$stateFile" || returnUndo $? "${undo[@]}" || return $?
      catchReturn "$handler" junitOpen tests=$tests failures=$failures errors=$errors skipped=$skipped assertions=$assertions time=$elapsed timestamp=$timestamp >>"$junitPath" || returnUndo $? "${undo[@]}" || return $?
      if [ -d "$junitTemp" ]; then
        catchReturn "$handler" find "$junitTemp/.xml" -type f | sort -u | xargs cat >>"$junitPath" || returnUndo $? "${undo[@]}" || return $?
        catchReturn "$handler" rm -rf "$junitTemp" || return $?
      fi
      catchReturn "$handler" junitClose >>"$junitPath" || return $?
    ) || return $?
  }
  ___hookTestsFinalize() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsFinalize "$@"
fi
