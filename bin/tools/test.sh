#!/usr/bin/env bash
#
# test.sh
#
# Standard testing wrapper
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__buildTestRequirements() {
  local handler="$1" && shift

  local bigBinary
  bigBinary=$(catchReturn "$handler" __bigTextBinary) || return $?
  [ -n "$bigBinary" ] || bigBinary="toilet"
  catchReturn "$handler" packageWhich "$bigBinary" "$bigBinary" || return $?
  catchReturn "$handler" packageWhich shellcheck shellcheck || return $?
  catchReturn "$handler" __pcregrepInstall || return $?
}

# Run Zesk Build tests
# See: testSuite
buildTestSuite() {
  local handler="_${FUNCNAME[0]}"
  local testHome

  __help "$handler" "$@" || return 0

  testHome="$(catchReturn "$handler" buildHome)" || return $?
  [ -d "$testHome/test" ] || throwArgument "$handler" "Missing test directory" || return $?

  # Include our own test support files if needed
  [ ! -d "$testHome/test/support" ] || catchEnvironment "$handler" bashSourcePath "$testHome/test/support" || return $?

  __buildTestRequirements "$handler" || return $?

  catchEnvironment "$handler" testTools testSuite --cd-away --delete-common --tests "$testHome/test/tools/" "$@" || return $?
}
_buildTestSuite() {
  name="$(buildEnvironmentGet APPLICATION_NAME)" fn="${FUNCNAME[0]#_}" testTools _testSuite "$@"
}
