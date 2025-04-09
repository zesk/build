#!/usr/bin/env bash
#
# test.sh
#
# Standard testing wrapper
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

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
  local usage="_${FUNCNAME[0]}"
  local testHome

  testHome="$(__catchEnvironment "$usage" buildHome)" || return $?
  [ -d "$testHome/test" ] || __throwArgument "$usage" "Missing test directory" || return $?

  # Include our own test support files if needed
  [ ! -d "$testHome/test/support" ] || __catchEnvironment "$usage" bashSourcePath "$testHome/test/support" || return $?

  # Custom HERE 3 lines
  __environment packageInstall || return $?
  __environment packageWhich shellcheck || return $?
  __environment packageWhich pcregrep || return $?

  # Custom HERE 1 line
  __catchEnvironment "$usage" testTools testSuite --delete-common --tests "$testHome/test/tools/" "$@" || return $?
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Custom HERE 1 line
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/build/tools.sh" || exit 99

__buildTestSuite "$@"
