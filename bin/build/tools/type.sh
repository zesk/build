#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends on no other .sh files
#
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: o ./docs/_templates/tools/type.md
# Test: o ./test/tools/type-tests.sh
#

###############################################################################
# ▐
# ▜▀ ▌ ▌▛▀▖▞▀▖
# ▐ ▖▚▄▌▙▄▘▛▀
#  ▀ ▗▄▘▌  ▝▀▘
#------------------------------------------------------------------------------

#
# Test if an argument is a positive floating point number
# (`1e3` notation NOT supported)
#
# Usage: {fn} argument ...
# Exit Code: 0 - if it is a number equal to or greater than zero
# Exit Code: 1 - if it is not a number equal to or greater than zero
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isUnsignedNumber() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
    case ${1#+} in '' | . | *[!0-9.]* | *.*.*) return 1 ;; esac
}

#
# Test if an argument is a floating point number
# (`1e3` notation NOT supported)
#
# Usage: {fn} argument ...
# Exit Code: 0 - if it is a floating point number
# Exit Code: 1 - if it is not a floating point number
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isNumber() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
  case ${1#[-+]} in '' | . | *[!0-9.]* | *.*.*) return 1 ;; esac
}

#
# Test if an argument is a signed integer
#
# Usage: {fn} argument ...
# Exit Code: 0 - if it is a signed integer
# Exit Code: 1 - if it is not a signed integer
# Credits: F. Hauri - Give Up GitHub (isuint_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isInteger() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
  case ${1#[-+]} in '' | *[!0-9]*) return 1 ;; esac
}

# isExecutable defined in platform

# Test if all arguments are callable as a command
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are callable as a command
# Exit code: 1 - One or or more arguments are callable as a command
isCallable() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
  if ! isFunction "$1" && ! isExecutable "$1"; then
    return 1
  fi
}

# True-ish
# Usage: {fn} value ...
# Succeeds when all arguments are "true"-ish
isTrue() {
  local value
  [ $# -gt 0 ] || return 1
  while [ $# -gt 0 ]; do
    value=$(lowercase "$1")
    case "$value" in
      1 | true | yes | enabled | y) ;;
      "" | 0 | false | no | disabled | n | null | nil | "0.0") return 1 ;;
      *)
        ! isInteger "$value" || [ "$value" -ne 0 ] || ! isNumber "$value" || [ "$(truncateFloat "$value")" -ne 0 ] || return 1
        ;;
    esac
    shift
  done
  return 0
}

# Usage: {fn} variableName
# Argument: variableName - Required. String. Variable to check is an array.
isArray() {
  local declareText
  declareText=$(declare -p "$1" 2>/dev/null) || return 1
  [ "${declareText#declare -a}" != "$declareText" ]
}

# IDENTICAL _type 28

#
# Test if an argument is a positive integer (non-zero)
#
# Usage: {fn} argument ...
# Exit Code: 0 - if it is a positive integer
# Exit Code: 1 - if it is not a positive integer
#
isPositiveInteger() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
  isUnsignedInteger "$1" || return 1
  # Find pesky "0" or "+0"
  [ "$1" -gt 0 ] || return 1
}

#
# Test if argument are bash functions
# Usage: {fn} string0
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - argument is bash function
# Exit code: 1 - argument is not a bash function
isFunction() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
