#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# watch-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testWatchDirectory() {
  assertExitCode --stderr-match "Missing directory" 2 watchDirectory || return $?
  assertExitCode 0 watchDirectory --timeout 1 . -type f -name '*.log' || return $?
  assertExitCode --stdout-match "Watch stopped after" 0 watchDirectory --verbose --timeout 1 . -type f -name '*.log' || return $?
  assertExitCode --stdout-match "Sleeping for" 0 watchDirectory --verbose --timeout 1 . -type f -name '*.log' || return $?
}
