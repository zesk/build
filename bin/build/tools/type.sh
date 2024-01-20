#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends on no other .sh files
#
# Shell Dependencies: awk sed date echo sort printf
# o ./docs/_templates/tools/type.md
# o ./test/tools/type-tests.sh
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
# Usage: {fn} argument
# Exit Code: 0 - if it is a number equal to or greater than zero
# Exit Code: 1 - if it is not a number equal to or greater than zero
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isUnsignedNumber() {
  case ${1#+} in
    '' | . | *[!0-9.]* | *.*.*)
      return 1
      ;;
  esac
}

#
# Test if an argument is a floating point number
# (`1e3` notation NOT supported)
#
# Usage: isInteger argument
# Exit Code: 0 - if it is a floating point number
# Exit Code: 1 - if it is not a floating point number
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isNumber() {
  case ${1#[-+]} in
    '' | . | *[!0-9.]* | *.*.*)
      return 1
      ;;
  esac
}

#
# Test if an argument is a signed integer
#
# Usage: isInteger argument
# Exit Code: 0 - if it is a signed integer
# Exit Code: 1 - if it is not a signed integer
# Credits: F. Hauri - Give Up GitHub (isuint_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isInteger() {
  case ${1#[-+]} in
    '' | *[!0-9]*)
      return 1
      ;;
  esac
}

#
# Test if an argument is an unsigned integer
#
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} string
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
#
isUnsignedInteger() {
  case $1 in
    '' | *[!0-9]*)
      return 1
      ;;
  esac
}

#
# Test if all arguments are bash functions
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. String to test if it is a bash function.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are bash functions
# Exit code: 1 - One or or more arguments are not a bash function
isFunction() {
  if [ $# -eq 0 ]; then
    return 1
  fi
  while [ $# -gt 0 ]; do
    if [ "$(type -t "$1")" != "function" ]; then
      return 1
    fi
    shift
  done
}

#
# Test if all arguments are executable binaries
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are executable binaries
# Exit code: 1 - One or or more arguments are not executable binaries
# Workaround: On Mac OS X the Docker environment thinks non-executable files are executable, notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how permissions are translated, I assume. Workaround falls.
isExecutable() {
  local lsMask
  if [ $# -eq 0 ]; then
    return 1
  fi
  while [ $# -gt 0 ]; do
    if [ -f "$1" ]; then
      # FAILS on plain files in docker on Mac OS X
      if [ ! -x "$1" ]; then
        return 1
      fi
      # shellcheck disable=SC2012
      if lsMask="$(ls -lhaF "$1" | awk '{ print $1 }')"; then
        if [ "$lsMask" = "${lsMask%%x*}" ]; then
          return 2
        fi
      fi
    else
      return 1
    fi
    shift
  done
  return 0
}

# Test if all arguments are callable as a command
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are callable as a command
# Exit code: 1 - One or or more arguments are callable as a command
isCallable() {
  if [ $# -eq 0 ]; then
    return 1
  fi
  while [ $# -gt 0 ]; do
    if ! isFunction "$1" || ! isExecutable "$1"; then
      return 1
    fi
    shift
  done
}
