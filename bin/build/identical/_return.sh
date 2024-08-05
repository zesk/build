#!/bin/bash
#
# Identical template
#
# Original of _return
#
# Syntactic sugar to allow a command to output a message to stderr and exit
# One line is nice as this is used nearly everywhere as a common escape from initialization problems.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL _return EOF
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# END of IDENTICAL _return
