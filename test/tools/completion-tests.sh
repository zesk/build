#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Completion tests
#

testCompletion() {
  assertExitCode 0 buildCompletion --alias foobar || return $?

  buildCompletion --alias foobar || return $?

  assertEquals "$(foobar todayDate)" "$(todayDate)" || return $?
}
