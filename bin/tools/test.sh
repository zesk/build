#!/usr/bin/env bash
#
# test.sh
#
# Standard testing wrapper
#
# IDENTICAL licenseHeader 11
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#

__buildTestRequirements() {
  local handler="$1" && shift

  local bigBinary
  bigBinary=$(catchReturn "$handler" __decorateBigBinary) || return $?
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

  helpArgument "$handler" "$@" || return 0

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

  catchReturn "$handler" buildTestSuite --make-index || return $?
}
_buildTestSuiteIndex() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
