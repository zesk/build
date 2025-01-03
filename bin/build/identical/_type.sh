#!/usr/bin/env bash
#
# Typeless languages make coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/type.md
# Test: o ./test/tools/type-tests.sh
#
# Depends: _return.sh
# Depends: isUnsignedInteger
# -- CUT BELOW HERE --

# IDENTICAL _type EOF

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
