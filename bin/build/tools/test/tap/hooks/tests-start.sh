#!/usr/bin/env bash
#
# TAP initialize
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-start

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../../tools.sh"; then

  # fn: hookRun tests-start
  # Summary: Run when a tests are started (before running)
  # Argument: stateFile - File. Required. State file for test suite.
  __hookTestsStartTAP() {
    local handler="_${FUNCNAME[0]}"

    local tapPath="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --tap) shift && tapPath="$(validate "$handler" "RealFileDirectory" "$argument" "${1-}")" || return $? ;;
      *)
        if [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    [ -n "$stateFile" ] || throwArgument "$handler" "stateFile is required" || return $?
    if [ -n "$tapPath" ]; then
      if [ "${tapPath%/}" != "$tapPath" ]; then
        tapPath=$(catchReturn "$handler" directoryRequire "$tapPath") || return $?
      fi
      if [ -d "$tapPath" ]; then
        tapPath="${tapPath%/}/results.tap" || return $?
      fi
      catchReturn "$handler" touch "$tapPath" || return $?

      local tapTemp && tapTemp=$(fileTemporaryName "$handler" -d) || return $?
      local tapCachePath="$tapTemp/.inc"
      catchReturn "$handler" muzzle directoryRequire "$tapTemp/.txt" || return $?
      catchReturn "$handler" muzzle directoryRequire "$tapCachePath" || return $?
      catchReturn "$handler" environmentValueWrite tapTemp "$tapTemp" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite tapPath "$tapPath" >>"$stateFile" || return $?
      catchReturn "$handler" environmentValueWrite tapCachePath "$tapTemp/.inc" >>"$stateFile" || return $?

      (
        local tests=0
        catchReturn "$handler" source "$stateFile" || return $?
        __testLoader "$handler" :

        catchReturn "$handler" __testSuiteTAP_plan "$tapCachePath" "$tests" >"$tapPath" || return $?
      ) || return $?

    fi

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }

  ___hookTestsStartTAP() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsStartTAP "$@"
fi
