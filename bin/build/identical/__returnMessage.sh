#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of __returnMessage
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#
# Syntactic sugar to allow a command to output a message to stderr and exit
#

# IDENTICAL returnMessage EOF

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.
# Argument: message ... - String. Optional. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local h="_${FUNCNAME[0]}" c="${1:-1}" && shift 2>/dev/null
  if [ "$c" = "--help" ]; then "$h" 0 && return 0 || return $?; fi
  # __IDENTICAL__ localTrace 1
  local trace="§ ${BASH_SOURCE[2]#"${BUILD_HOME-}/"}:${BASH_LINENO[1]-} ${FUNCNAME[2]}"
  isUnsignedInteger "$c" || returnMessage 2 "${h#_} non-integer \"$c\"" "$@" "($trace)" || return $?
  if [ "$c" != "0" ]; then printf "%s [%s] %s (%s)\n" "❌" "$c" "${*-§}" "$trace" 1>&2; else printf "%s %s\n" "✅" "${*-§}"; fi && return "$c"
}
_returnMessage() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is value an unsigned integer?
# Test if a value is a 0 or greater integer. Leading "+" is ok.
# See: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL returnMessage
