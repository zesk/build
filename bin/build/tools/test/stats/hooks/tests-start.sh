#!/usr/bin/env bash
#
# Stats
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-start

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun tests-start
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestsStartStats() {
    local handler="_${FUNCNAME[0]}"

    local statsPath="" statsReportPath="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --stats) shift && statsPath="$(validate "$handler" "RealFileDirectory" "$argument" "${1-}")" || return $? ;;
      --stats-report) shift && statsReportPath="$(validate "$handler" "RealFileDirectory" "$argument" "${1-}")" || return $? ;;
      *)
        if [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?

    if [ -n "$statsReportPath" ]; then
      if [ "${statsReportPath%/}" != "$statsReportPath" ]; then
        statsReportPath=$(catchReturn "$handler" directoryRequire "$statsReportPath") || return $?
      fi
      if [ -d "$statsReportPath" ]; then
        statsReportPath="${statsReportPath%/}/stats.txt" || return $?
      fi
      [ -n "$statsPath" ] || statsPath="$(dirname "$statsReportPath")"
    fi

    if [ -n "$statsPath" ]; then
      if [ "${statsPath%/}" != "$statsPath" ]; then
        statsPath=$(catchReturn "$handler" directoryRequire "$statsPath") || return $?
      fi
      if [ -d "$statsPath" ]; then
        statsPath="${statsPath%/}/results.stats" || return $?
      fi
      catchReturn "$handler" touch "$statsPath" || return $?
      local statsTempPath && statsTempPath=$(fileTemporaryName "$handler") || return $?
      catchReturn "$handler" environmentValueWrite statsPath "$statsPath" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite statsTempPath "$statsTempPath" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite statsReportPath "$statsReportPath" >>"$stateFile" || return $?
      local ss=() && read -r -a ss < <(assertStatistics) || return $?
      catchReturn "$handler" environmentValueWriteArray statsAssertStatistics "${ss[@]}" >>"$stateFile" || return $?
    fi

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }

  ___hookTestsStartStats() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsStartStats "$@"
fi
