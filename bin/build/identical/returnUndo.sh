#!/usr/bin/env bash
#
# Original of returnUndo
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.

# IDENTICAL returnUndo EOF

# Run a function and preserve exit code
# Returns `code`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: code - Required. UnsignedInteger. Exit code to return.
# Argument: undoFunction - Optional. Command to run to undo something. Return status is ignored.
# Argument: -- - Flag. Optional. Used to delimit multiple commands.
# As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.
# Example:     local undo thing
# Example:     thing=$(catchEnvironment "$handler" createLargeResource) || return $?
# Example:     undo+=(-- deleteLargeResource "$thing")
# Example:     thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
# Example:     undo+=(-- deleteMassiveResource "$thing")
# Requires: isPositiveInteger catchArgument decorate execute
# Requires: usageDocument
returnUndo() {
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" code="${1-}" args=()
  # __IDENTICAL__ __checkHelp1__handler 1
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0
  shift
  # __IDENTICAL__ __checkCode__handler 1
  isInteger "$code" || throwArgument "$__handler" "Not integer: $(decorate value "[$code]") (#$__count $(decorate each code -- "${__saved[@]}"))" || return $?
  while [ $# -gt 0 ]; do
    case "$1" in
    --)
      [ "${#args[@]}" -eq 0 ] || execute "${args[@]}" || :
      args=()
      ;;
    *)
      args+=("$1")
      ;;
    esac
    shift
  done
  [ "${#args[@]}" -eq 0 ] || execute "${args[@]}" || :
  return "$code"
}
_returnUndo() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
