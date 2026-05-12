#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of stringContains
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL stringContains EOF

# Argument: haystack - String. Required. String to search.
# Argument: needle ... - String. Optional. One or more strings to find as a substring of `haystack`.
# Return Code: 0 - IFF ANY needle matches as a substring of haystack
# Return Code: 1 - No needles found in haystack
# Summary: Find whether a substring exists in one or more strings
# Does needle exist as a substring of haystack?
stringContains() {
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"

  [ -n "$haystack" ] || return 1
  shift
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle="$1"
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringContains() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
