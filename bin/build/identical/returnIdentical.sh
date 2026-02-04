#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnIdentical EOF

# Summary: Identical return code
# Return code is `identical`
# Return Code: 105
returnIdentical() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnIdenticalCode 1
  return 105 # "$(returnCode identical)"
}
_returnIdentical() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
