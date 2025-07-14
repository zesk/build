#!/usr/bin/env bash
#
# Typeless languages make coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.

# ------------------------------- CUT BELOW HERE -------------------------------

# IDENTICAL _type EOF

# Test if an argument is a positive integer (non-zero)
# Takes one argument only.
# Argument: value - EmptyString. Required. Value to check if it is an unsigned integer
# Exit Code: 0 - if it is a positive integer
# Exit Code: 1 - if it is not a positive integer
# Requires: __catchArgument isUnsignedInteger usageDocument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __catchArgument "$usage" "Single argument only: $*" || return $?
  if isUnsignedInteger "$1"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  if [ "$1" = "--help" ]; then
    "$usage" 0
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Test if argument are bash functions
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - argument is bash function
# Exit code: 1 - argument is not a bash function
# Requires: __catchArgument isUnsignedInteger usageDocument type
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __catchArgument "$usage" "Single argument only: $*" || return $?
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
