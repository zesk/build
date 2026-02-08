#!/usr/bin/env bash
#
# jUnit start
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-start

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../tools.sh"; then

  # fn: hookRun tests-start
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestsStart() {
    local handler="_${FUNCNAME[0]}"

    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "$@" || return $?

    local junitPath="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --junit) shift && junitPath="$(validate "$handler" "FileDirectory" "${1-}")" || return $? ;;
      *)
        if [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?
    local home && home=$(catchReturn "$handler" buildHome) || return $?
    if [ -n "$junitPath" ]; then
      if [ -d "$junitPath" ]; then
        junitPath="$(catchReturn "$handler" realPath "$junitPath")/results.xml" || return $?
      fi
      if [ ! -f "$junitPath" ]; then
        catchReturn "$handler" touch "$junitPath" || return $?
      fi
      local junitTemp && junitTemp=$(fileTemporaryName "$handler" -d) || return $?
      catchReturn "$handler" muzzle directoryRequire "$junitTemp/.xml" || return $?
      catchReturn "$handler" environmentValueWrite junitTemp "$junitTemp" >>"$stateFile" || return $?
    fi
    catchReturn "$handler" environmentValueWrite junitPath "$junitPath" >>"$stateFile" || return $?
  }
  ___hookTestsStart() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  ___hookTestsStart "$@"
fi
