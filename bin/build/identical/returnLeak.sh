#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of returnLeak
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnLeak EOF

# Summary: Leak return code
# Return code is `leak`
# DOC TEMPLATE: returnCodeLeak 1
# Return Code: 108 - A leak was detected in the command
returnLeak() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnLeakCode 1
  return 108 # "$(returnCode leak)"
}
_returnLeak() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
