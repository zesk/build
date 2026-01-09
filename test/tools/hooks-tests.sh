#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# hooks-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook tests

testHookVersionCurrent() {
  assertExitCode 0 hookVersionCurrent || return $?
  assertEquals "$(hookVersionCurrent)" "$(hookRun version-current)" || return $?
}

testHookVersionLive() {
  assertExitCode 0 hookVersionLive || return $?
  assertEquals "$(hookVersionLive)" "$(hookRun --application "$(buildHome)" version-live)" || return $?
}
