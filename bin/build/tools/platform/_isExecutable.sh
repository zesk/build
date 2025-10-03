#!/usr/bin/env bash
#
# Non-patched version of isExecutable (other one works around a Docker bug)
#
# Use this when we can!
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#

# Test if all arguments are executable binaries
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are executable binaries
# Return Code: 1 - One or or more arguments are not executable binaries
# Requires: returnArgument which
isExecutable() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  if [ -f "$1" ]; then
    # FAILS on plain files in docker on Mac OS X
    if [ ! -x "$1" ]; then
      return 1
    fi
  elif [ -z "$(which "$1")" ]; then
    return 1
  fi
  return 0
}
_isExecutable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
