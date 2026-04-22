#!/bin/bash
#
# Identical template
#
# Original of helpArgument
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
#
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.

# IDENTICAL helpArgument EOF

# Simple help argument handler.
#
# Easy `--help` handler for any function useful when it's the only option.
#
# Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)
#
# Oddly one of the few functions we can not offer the `--help` flag for.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: --only - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: handlerFunction - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: arguments ... - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.
#
# Example:     # NOT DEFINED handler
# Example:
# Example:     helpArgument "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
# Example:     # Argument 1 absolutely exists
# Example:     [ "$1" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
# Example:
# Example:     # DEFINED handler
# Example:
# Example:     local handler="_${FUNCNAME[0]}"
# Example:     helpArgument "$handler" "$@" || return 0
# Example:     [ "$1" != "--help" ] || helpArgument "$handler" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
# Example:     [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
# Example:
# Example:     # Blank Arguments for help
# Example:     [ $# -gt 0 ] || helpArgument "_${FUNCNAME[0]}" --help || return 0
# Example:     [ $# -gt 0 ] || helpArgument "$handler" --help || return 0
#
# DEPRECATED-Example: [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return $?
# DEPRECATED-Example: [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return $?
#
# Requires: throwArgument bashDocumentation _helpArgument
# Return code: 0 - Help was not found or displayed
# Return code: 1 - Help was found and displayed
# Return code: 2 - Argument error
helpArgument() {
  [ $# -gt 0 ] || ! _helpArgument 0 || return 0
  local flag="--help"
  local handler="${1-}" && shift
  if [ "$handler" = "--only" ]; then
    handler="${1-}" && shift
    [ $# -gt 0 ] || return 0
    [ "$#" -eq 1 ] && [ "${1-}" = "$flag" ] || throwArgument "$handler" "Only argument allowed is \"$flag\": $*" || return $?
  fi
  while [ $# -gt 0 ]; do
    [ "$1" != "$flag" ] || ! "$handler" 0 || return 1
    shift
  done
  return 0
}
_helpArgument() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
