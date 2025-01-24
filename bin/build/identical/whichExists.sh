#!/bin/bash
#
# Original of whichExists
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL whichExists EOF
# Usage: {fn} binary ...
# Argument: binary - Required. String. Binary to find in the system `PATH`.
# Exit code: 0 - If all values are found
whichExists() {
  local __count=$# && [ $# -gt 0 ] || _argument "no arguments" || return $?
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || _argument "blank argument #$((__count - $# + 1))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}
