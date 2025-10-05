#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends on no other .sh files
#
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: o ./documentation/source/tools/type.md
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
# handler: {fn} argument ...
# Return Code: 0 - if it is a number equal to or greater than zero
# Return Code: 1 - if it is not a number equal to or greater than zero
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isUnsignedNumber() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  case ${1#+} in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | . | *[!0-9.]* | *.*.*) return 1 ;; esac
}

#
# Test if an argument is a floating point number
# (`1e3` notation NOT supported)
#
# handler: {fn} argument ...
# Return Code: 0 - if it is a floating point number
# Return Code: 1 - if it is not a floating point number
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isNumber() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  # `-help` match is EXPLICIT as the case removes the first dash
  case ${1#[-+]} in -help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | . | *[!0-9.]* | *.*.*) return 1 ;; esac
}

#
# Test if an argument is a signed integer
#
# handler: {fn} argument ...
# Return Code: 0 - if it is a signed integer
# Return Code: 1 - if it is not a signed integer
# Argument: value - EmptyString. The value to test.
# Credits: F. Hauri - Give Up GitHub (isuint_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isInteger() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  # `-help` match is EXPLICIT as the case removes the first dash
  case ${1#[-+]} in -help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# isExecutable defined in platform

# Test if all arguments are callable as a command
# handler: {fn} string0 [ string1 ... ]
# Argument: string - Required. EmptyString. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are callable as a command
# Return Code: 1 - One or or more arguments are callable as a command
isCallable() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if ! isFunction "$1" && ! isExecutable "$1"; then
    return 1
  fi
}
_isCallable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# True-ish
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: value ... - EmptyString. One or more values to test.
# Succeeds when all arguments are "true"-ish
isTrue() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || return 1
  while [ $# -gt 0 ]; do
    local value
    # -- removes special meaning from `--help
    value=$(lowercase -- "$1")
    case "$value" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    1 | true | yes | enabled | y) ;;
    "" | 0 | false | no | disabled | n | null | nil | "0.0") return 1 ;;
    *)
      ! isInteger "$value" || [ "$value" -ne 0 ] || ! isNumber "$value" || [ "$(floatTruncate "$value")" -ne 0 ] || return 1
      ;;
    esac
    shift
  done
  return 0
}
_isTrue() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Bash types beyond `type -t`
isType() {
  local text
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  text=$(declare -p "${1-}" 2>/dev/null) || return 1
  case "$text" in
  *"declare -ax "*) printf -- "%s\n" "array" "export" ;;
  *"declare -a "*) printf -- "%s\n" "array" "local" ;;
  *"declare -x "*) printf -- "%s\n" "string" "export" ;;
  *"declare -- "*) printf -- "%s\n" "string" "local" ;;
  *"declare -fx "*) printf -- "%s\n" "function" "export" ;;
  *"declare -f "*) printf -- "%s\n" "function" "local" ;;
  *) throwArgument "$handler" "Unknown type: $1 -> \"$text\"" || return $? ;;
  esac
}
_isType() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ isArray 19

# Is a variable declared as an array?
# Argument: variableName - Required. String. Variable to check is an array.
isArray() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || return 1
    case "$(declare -p "${1-}" 2>/dev/null)" in
    *"declare -a"*) ;;
    *) return 1 ;;
    esac
    shift
  done
  return 0
}
_isArray() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _type 42

# Test if an argument is a positive integer (non-zero)
# Takes one argument only.
# Argument: value - EmptyString. Required. Value to check if it is an unsigned integer
# Return Code: 0 - if it is a positive integer
# Return Code: 1 - if it is not a positive integer
# Requires: catchArgument isUnsignedInteger usageDocument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if isUnsignedInteger "${1-}"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if argument are bash functions
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - argument is bash function
# Return Code: 1 - argument is not a bash function
# Requires: catchArgument isUnsignedInteger usageDocument type
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
