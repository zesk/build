#!/usr/bin/env bash
#
# Typeless languages make coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2026 Market Acumen, Inc.

# ------------------------------- CUT BELOW HERE -------------------------------

# IDENTICAL _type EOF

# Test if an argument is a positive integer (non-zero)
# Takes one argument only.
# Argument: value - EmptyString. Required. Value to check if it is an unsigned integer
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - if it is a positive integer
# Return Code: 1 - if it is not a positive integer
# Requires: catchArgument isUnsignedInteger bashDocumentation helpArgument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  if isUnsignedInteger "${1-}"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if argument are bash functions
# Argument: string - String. Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - argument is bash function
# Return Code: 1 - argument is not a bash function
# Requires: catchArgument isUnsignedInteger bashDocumentation type helpArgument
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
