#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of returnExit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnExit EOF

# Summary: Exit return code
# Return code is `exit`
# DOC TEMPLATE: returnCodeExit 1
# Return Code: 120 - Calling function should exit
returnExit() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnExitCode 1
  return 120 # "$(returnCode exit)"
}
_returnExit() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
