#!/usr/bin/env bash
#
# hooks-tests.sh
#
# Hook tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testHookVersionCurrent() {
  assertExitCode 0 hookVersionCurrent || return $?
  assertEquals "$(hookVersionCurrent)" "$(runHook version-current)" || return $?
}

testHookVersionLive() {
  assertExitCode 0 hookVersionLive || return $?
  assertEquals "$(hookVersionLive)" "$(runHook --application "$(buildHome)" version-live)" || return $?
}
