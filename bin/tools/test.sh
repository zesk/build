#!/usr/bin/env bash
#
# test.sh
#
# Standard testing wrapper
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__buildTestRequirements() {
  local handler="$1" && shift

  local bigBinary
  bigBinary=$(__catch "$handler" __bigTextBinary) || return $?
  [ -n "$bigBinary" ] || bigBinary="toilet"
  __catch "$handler" packageWhich "$bigBinary" "$bigBinary" || return $?
  __catch "$handler" packageWhich shellcheck shellcheck || return $?
  __catch "$handler" __pcregrepInstall || return $?
}

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

  testHome="$(__catch "$handler" buildHome)" || return $?
  [ -d "$testHome/test" ] || __throwArgument "$handler" "Missing test directory" || return $?

  # Include our own test support files if needed
  [ ! -d "$testHome/test/support" ] || __catchEnvironment "$handler" bashSourcePath "$testHome/test/support" || return $?

  __buildTestRequirements "$handler" || return $?

  __catchEnvironment "$handler" testTools testSuite --cd-away --delete-common --tests "$testHome/test/tools/" "$@" || return $?
}
___buildTestSuite() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
