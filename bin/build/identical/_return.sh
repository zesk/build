#!/bin/bash
#
# Copy of _return
#
# Syntactic sugar to allow a command to output a message to stderr and exit
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}
