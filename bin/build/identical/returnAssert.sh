#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL returnAssert EOF

# Return code is `assert`
# Return Code: 97
returnAssert() {
  # _IDENTICAL_ returnAssertCode 1
  return 97 # "$(returnCode assert)"
}
