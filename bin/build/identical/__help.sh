#!/bin/bash
#
# Identical template
#
# Original of __help
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __help EOF

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
# Argument: usageFunction - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: arguments ... - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.
#
# Example:     # NOT DEFINED usage local usage="_${FUNCNAME[0]}"
# Example:
# Example:     __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
# Example:
# Example:     # DEFINED usage
# Example:
# Example:     local usage="_${FUNCNAME[0]}"
# Example:     __help "$usage" "$@" || return 0
# Example:     [ "$1" != "--help" ] || __help "$usage" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
# Example:
# Example:     # Blank Arguments for help
# Example:     [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
# Example:     [ $# -gt 0 ] || __help "$usage" --help || return 0
#
# Requires: __throwArgument usageDocument
__help() {
  [ $# -gt 0 ] || ! ___help 0 || return 0
  local usage="${1-}" && shift
  if [ "$usage" = "--only" ]; then
    usage="${1-}" && shift
    [ $# -gt 0 ] || return 0
    [ "$#" -eq 1 ] && [ "${1-}" = "--help" ] || __throwArgument "$usage" "Only argument allowed is --help: \"${1-}\"" || return $?
  fi
  while [ $# -gt 0 ]; do
    if [ "$1" = "--help" ]; then
      "$usage" 0
      return 1
    fi
    shift
  done
  return 0
}
___help() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
