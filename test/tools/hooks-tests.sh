#!/usr/bin/env bash
#
# hooks-tests.sh
#
# Hook tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testHookVersionCurrent() {
  assertExitCode 0 hookVersionCurrent || return $?
  assertEquals "$(hookVersionCurrent)" "$(hookRun version-current)" || return $?
}

testHookVersionLive() {
  assertExitCode 0 hookVersionLive || return $?
  assertEquals "$(hookVersionLive)" "$(hookRun --application "$(buildHome)" version-live)" || return $?
}
