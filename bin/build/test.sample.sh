#!/usr/bin/env bash
#
# test.sh
#
# Standard testing wrapper
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/tools.sh" || exit 99

#
# Standard test layout
#
# Test functions prefixed with the word `test` in:
#
# - ./test/tests/suite-tests.sh
#
# Test support files (available per test):
#
# - ./test/support/*.sh -
#
# Once ready, do `testTools testSuite --help`
#
__buildTestSuite() {
  local handler="_${FUNCNAME[0]}"
  local testHome

  testHome="$(returnCatch "$handler" buildHome)" || return $?
  [ -d "$testHome/test" ] || throwArgument "$handler" "Missing test directory" || return $?

  # Include our own test support files if needed
  [ ! -d "$testHome/test/support" ] || catchEnvironment "$handler" bashSourcePath "$testHome/test/support" || return $?

  catchEnvironment "$handler" testTools testSuite --tests "$testHome/test/tests/" "$@" || return $?
}
___buildTestSuite() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildTestSuite "$@"
