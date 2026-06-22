#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: tests-stop

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

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
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
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
      local tests=0 timestamp="never" plumber="-" housekeeper="-"
      local name && name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
      catchReturn "$handler" source "$stateFile" || return $?
      local host && host=$(catchReturn "$handler" networkNameFull) || return $?
      local suffix="plumber=$plumber, housekeeper=$housekeeper"
      if [ -z "$terminateReason" ]; then
        title="$name Tests Passed (#$tests)"
        message="Completed on $timestamp @ $host. $suffix"
      else
        title="$name Tests Failed (#$tests)"
        message="$terminateReason on $timestamp @ $host. $suffix"
      fi
      catchReturn "$handler" hookNotify --title "$title" "$message" || statusMessage --last decorate warning "Notify failed. Continuing." || return $?
    ) || return $?

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookTestsStop() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestsStop "$@"
fi
