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

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/tools.sh" || exit 99

# Standard test layout
#
# Test functions prefixed with the word `test` in:
#
# - `./test/tests/suite-tests.sh`
#
# Test support files (available per test):
#
# - `./test/support/*.sh` -
#
# Once ready, do `testSuite --help`
__buildTestSuite() {
  local handler="_${FUNCNAME[0]}"
  local testHome

  testHome="$(catchReturn "$handler" buildHome)" || return $?
  [ -d "$testHome/test" ] || throwArgument "$handler" "Missing test directory" || return $?

  # Include our own test support files if needed
  [ ! -d "$testHome/test/support" ] || catchEnvironment "$handler" bashSourcePath "$testHome/test/support" || return $?

  catchEnvironment "$handler" testSuite --tests "$testHome/test/tests/" "$@" || return $?
}
___buildTestSuite() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildTestSuite "$@"
