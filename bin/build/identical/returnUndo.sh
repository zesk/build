#!/usr/bin/env bash
#
# Original of returnUndo
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.

# IDENTICAL returnUndo EOF

# Run a function and preserve exit code
# Returns `exitCode`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: exitCode - Required. UnsignedInteger. Exit code to return.
# Argument: undoFunction - Optional. Command to run to undo something. Return status is ignored.
# Argument: -- - Flag. Optional. Used to delimit multiple commands.
# As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.
# Example:     local undo thing
# Example:     thing=$(__catchEnvironment "$handler" createLargeResource) || return $?
# Example:     undo+=(-- deleteLargeResource "$thing")
# Example:     thing=$(__catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
# Example:     undo+=(-- deleteMassiveResource "$thing")
# Requires: isPositiveInteger __catchArgument decorate __execute
# Requires: usageDocument
returnUndo() {
  [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local __count=$# __saved=("$@") __usage="_${FUNCNAME[0]}" exitCode="${1-}" args=()
  shift
  isUnsignedInteger "$exitCode" || __catchArgument "$__usage" "Not an integer $(decorate value "$exitCode") (#$__count: $(decorate each code "${__saved[@]+"${__saved[@]}"}"))" || return $?
  while [ $# -gt 0 ]; do
    case "$1" in
    --)
      [ "${#args[@]}" -eq 0 ] || __execute "${args[@]}" || :
      args=()
      ;;
    *)
      args+=("$1")
      ;;
    esac
    shift
  done
  [ "${#args[@]}" -eq 0 ] || __execute "${args[@]}" || :
  return "$exitCode"
}
_returnUndo() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
