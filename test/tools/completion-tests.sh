#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# completion-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testCompletion() {
  assertExitCode 0 buildCompletion --alias foobar || return $?

  buildCompletion --alias foobar || return $?

  assertEquals "$(foobar todayDate)" "$(todayDate)" || return $?
}
