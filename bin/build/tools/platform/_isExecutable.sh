#!/usr/bin/env bash
#
# Non-patched version of isExecutable (other one works around a Docker bug)
#
# Use this when we can!
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
#

#
# Test if all arguments are executable binaries
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are executable binaries
# Exit code: 1 - One or or more arguments are not executable binaries
isExecutable() {
  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
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
