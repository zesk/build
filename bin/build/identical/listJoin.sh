#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of listJoin
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL listJoin EOF

# Output a list of items joined by a character
# Output: text
# Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.
# Argument: text0 ... - String. Optional. One or more strings to join
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
listJoin() {
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
  local IFS="${1-:0:1}"
  shift || :
  printf "%s" "$*"
}
_listJoin() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
