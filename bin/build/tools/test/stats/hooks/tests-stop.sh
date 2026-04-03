#!/usr/bin/env bash
#
# Stats
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
      local statsPath="" statsReportPath="" statsTempPath=""
      catchReturn "$handler" source "$stateFile" || return $?
      if [ -f "$statsPath" ]; then
        [ -z "$terminateReason" ] || catchReturn "$handler" printf "%s\n" "### TERMINATED $terminateReason" >>"$statsPath" || return $?
        exec 3>&1
        [ -z "$statsReportPath" ] || exec 3>"$statsReportPath"
        __testStats "$handler" "$statsTempPath" "$statsPath" 1>&3
        [ -z "$statsReportPath" ] || exec 3>-
        exec 3>&-
        catchReturn "$handler" environmentValueWrite "statsTempPath" "" >>"$stateFile" || return $?
        catchReturn "$handler" environmentValueWrite "statsPath" "" >>"$stateFile" || return $?
        catchReturn "$handler" environmentValueWrite "statsReportPath" "" >>"$stateFile" || return $?
      fi
    ) || return $?

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookTestsStop() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __testStats() {
    local handler="$1" && shift
    local statsFile="$1" && shift
    local targetFile="$1" && shift
    catchEnvironment "$handler" sort -rn <"$statsFile" >"$targetFile" || return $?
    catchEnvironment "$handler" rm -rf "$statsFile" || return $?
    catchReturn "$handler" decorate box "Slowest tests" || return $?
    catchReturn "$handler" head -n 50 <"$targetFile" | catchReturn "$handler" __testStatsFormat | printfOutputEmpty "%s\n" "None." || return $?
    catchReturn "$handler" decorate box "Fastest tests" || return $?
    catchReturn "$handler" grepSafe -v -e '^0 ' "$targetFile" | catchReturn "$handler" tail -n 20 | catchReturn "$handler" __testStatsFormat | printfOutputEmpty "%s\n" "None." || return $?
    catchReturn "$handler" decorate box "Zero-second tests" || return $?
    local zeroTests=()
    IFS=$'\n' read -d '' -r -a zeroTests < <(grepSafe -e '^0 ' "$targetFile" | awk '{ print $2 }') || :
    catchReturn "$handler" printf -- "%s " "${zeroTests[@]+"${zeroTests[@]}"}" | printfOutputEmpty "%s\n" "None." || return $?
    catchReturn "$handler" printf -- "\n" || return $?
    __testLoader "$handler" : || return $?
    local afFile && if afFile=$(__assertedFunctions); then
      catchReturn "$handler" decorate box "Functions asserted (cumulative)" || return $?
      catchReturn "$handler" cat "$afFile" || return $?
      lines=$(catchReturn "$handler" fileLineCount <"$afFile") || return $?
      catchReturn "$handler" decorate info "$lines $(localePlural "$lines" "function" "functions")" || return $?
      catchReturn "$handler" printf -- "\n" || return $?
    else
      catchReturn "$handler" decorate subtle "Assertions not tracked with $(decorate code "TEST_TRACK_ASSERTIONS")" || return $?
    fi
  }

  __testStatsFormat() {
    local milliseconds functionName
    while read -r milliseconds functionName; do
      if isUnsignedInteger "$milliseconds"; then
        printf -- "%s %s\n" "$(decorate value "$(textAlignRight 6 "$(timingFormat "$milliseconds")")")" "$(decorate code "$functionName")"
      else
        printf "%s %s\n" "$milliseconds" "$functionName"
      fi
    done
  }

  __hookTestsStop "$@"
fi
