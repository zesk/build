#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of returnAssert
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnAssert EOF

# Return code is `assert`
# Summary: Assertion return code
# Return Code: 97
returnAssert() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnAssertCode 1
  return 97 # "$(returnCode assert)"
}
_returnAssert() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
