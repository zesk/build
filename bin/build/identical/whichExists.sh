#!/bin/bash
#
# Original of realPath
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL whichExists EOF
# Usage: {fn} binary ...
# Argument: binary - Required. String. Binary to find in the system `PATH`.
# Exit code: 0 - If all values are found
whichExists() {
  local nArguments=$# && [ $# -gt 0 ] || _argument "no arguments" || return $?
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || _argument "blank argument #$((nArguments - $# + 1))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}
