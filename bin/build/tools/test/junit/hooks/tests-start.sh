#!/usr/bin/env bash
#
# jUnit start
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-start

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun tests-start
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestsStartJUnit() {
    local handler="_${FUNCNAME[0]}"

    local junitPath="" stateFile="" junitKeepTemp=false

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --debug) junitKeepTemp=true ;;
      --junit) shift && junitPath="$(validate "$handler" "RealFileDirectory" "$argument" "${1-}")" || return $? ;;
      *)
        if [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?
    if [ -n "$junitPath" ]; then
      if [ "${junitPath%/}" != "$junitPath" ]; then
        junitPath=$(catchReturn "$handler" directoryRequire "$junitPath") || return $?
      fi
      if [ -d "$junitPath" ]; then
        junitPath="$junitPath/results.xml" || return $?
      fi
      if [ ! -f "$junitPath" ]; then
        catchReturn "$handler" touch "$junitPath" || return $?
      fi
      local junitTemp
      if $junitKeepTemp; then
        junitTemp="$(dirname "$junitPath")/.junitTemp" || return $?
        catchReturn "$handler" rm -rf "$junitTemp" || return $?
      else
        junitTemp="$(fileTemporaryName "$handler" -d)" || return $?
      fi
      catchReturn "$handler" muzzle directoryRequire "$junitTemp/.suiteXML" || return $?
      catchReturn "$handler" muzzle directoryRequire "$junitTemp/.totals/" || return $?
      catchReturn "$handler" environmentValueWrite junitKeepTemp "$junitKeepTemp" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite junitTemp "$junitTemp" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite junitPath "$junitPath" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite timestamp "$(date "+%FT%T")" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite start "$(timingStart)" >>"$stateFile" || return $?
    fi

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookTestsStartJUnit() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsStartJUnit "$@"
fi
