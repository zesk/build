#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of returnIdentical
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnIdentical EOF

# Summary: Identical return code
# Return code is `identical`
# DOC TEMPLATE: returnCodeIdentical 1
# Return Code: 105 - The identical check found discrepancies.
returnIdentical() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnIdenticalCode 1
  return 105 # "$(returnCode identical)"
}
_returnIdentical() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
