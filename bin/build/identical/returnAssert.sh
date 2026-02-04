#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnAssert EOF

# Return code is `assert`
# Summary: Assertion return code
# Return Code: 97
returnAssert() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnAssertCode 1
  return 97 # "$(returnCode assert)"
}
_returnAssert() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
