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

  # CUSTOM BEGIN
  local bigBinary
  bigBinary=$(__catchEnvironment "$usage" __bigTextBinary) || return $?
  [ -n "$bigBinary" ] || bigBinary="toilet"
  __catchEnvironment "$usage" packageWhich "$bigBinary" "$bigBinary" || return $?
  __catchEnvironment "$usage" packageWhich shellcheck shellcheck || return $?
  __catchEnvironment "$usage" __pcregrepInstall || return $?
  # CUSTOM END

  __catchEnvironment "$usage" testTools testSuite --cd-away --delete-common --tests "$testHome/test/tools/" "$@" || return $?
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Custom HERE 1 line
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/build/tools.sh" || exit 99

__buildTestSuite "$@"
