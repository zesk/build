#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnExit EOF

# Summary: Exit return code
# Return code is `exit`
# Return Code: 120
returnExit() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnExitCode 1
  return 120 # "$(returnCode exit)"
}
_returnExit() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
