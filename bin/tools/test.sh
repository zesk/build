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

  ! consoleHasColors || decorateInitialized || muzzle consoleConfigureDecorate || :

  __help "$handler" "$@" || return 0

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  [ -d "$home/test" ] || throwArgument "$handler" "Missing test directory" || return $?

  # Include our own test support files if needed
  [ ! -d "$home/test/support" ] || catchEnvironment "$handler" bashSourcePath "$home/test/support" || return $?

  __buildTestRequirements "$handler" || return $?

  catchEnvironment "$handler" testSuite --cd-away --delete-common --tests "$home/test/tools/" --index-file "$home/test/tests.index" "$@" || return $?
}
_buildTestSuite() {
  name="$(buildEnvironmentGet APPLICATION_NAME)" fn="${FUNCNAME[0]#_}" _testSuite "$@"
}

# Generate `./test/tests.index` for Zesk Build
buildTestSuiteIndex() {
  local handler="_${FUNCNAME[0]}"
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  catchEnvironment "$handler" buildTestSuite --make-index || return $?
}
_buildTestSuiteIndex() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
