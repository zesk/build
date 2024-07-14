#!/bin/bash
#
# Copy of _return
#
# Syntactic sugar to allow a command to output a message to stderr and exit
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL _return EOF
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}
