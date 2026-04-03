#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnLeak EOF

# Summary: Leak return code
# Return code is `leak`
# Return Code: 108
returnLeak() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnLeakCode 1
  return 108 # "$(returnCode leak)"
}
_returnLeak() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
