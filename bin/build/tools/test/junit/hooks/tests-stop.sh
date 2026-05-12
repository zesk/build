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

    local junitPath="" stateFile="" terminateReason=""

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

    local returnCode=0 && (
      # local flags="" __count="" __saved=""
      local tests=0 failures=0 errors=0 skipped=0 start=0 timestamp="none" junitTemp="" junitKeepTemp=false

      __testLoader "$handler" : || return $?
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -n "$junitPath" ] && [ -n "$junitTemp" ]; then
        local allStats="$junitTemp/all.stats"

        __collectStats "$handler" "$junitTemp/.totals" tests success failures errors skipped >>"$allStats" || return $?
        catchReturn "$handler" source "$allStats" || return $?
        $junitKeepTemp || catchReturn "$handler" rm -f "$allStats" || return $?

        local total && total=$(catchReturn "$handler" assertStatistics --total) || return $?
        local junit=(
          "tests=$tests"
          "failures=$failures"
          "errors=$errors"
          "skipped=$skipped"
          "assertions=$total"
          "time=$(timingFormat "$(timingElapsed "$start")")"
          "timestamp=$timestamp"
        )

        if [ -n "$terminateReason" ]; then
          junit+=("terminated=true" "reason=$terminateReason")
        fi
        catchReturn "$handler" junitOpen name="$(buildEnvironmentGet APPLICATION_NAME)" "${junit[@]}" >"$junitPath" || return $?
        if [ -d "$junitTemp" ]; then
          catchReturn "$handler" find "$junitTemp/.suiteXML" -type f | sort -u | xargs cat >>"$junitPath" || return $?
          $junitKeepTemp || catchReturn "$handler" rm -rf "$junitTemp" || return $?
        fi
        catchReturn "$handler" junitClose >>"$junitPath" || return $?
      fi
    ) || returnCode=$?

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?

    return "$returnCode"
  }
  ___hookTestsStop() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsStop "$@"
fi
