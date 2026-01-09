#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# user-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testUserHome() {
  export HOME

  mockEnvironmentStart HOME "${HOME-}"

  HOME=/etc/does-not

  assertNotExitCode --stderr-match "not a directory" --line "$LINENO" 0 userHome || return $?

  HOME=$(pwd)

  local cleanHome

  cleanHome="${HOME%/}"
  assertDirectoryExists "$HOME" || return $?
  assertExitCode --stdout-match "$cleanHome" --line "$LINENO" 0 userHome || return $?
  assertEquals "$cleanHome" "$(userHome)" || return $?
  assertEquals "$cleanHome/extra" "$(userHome extra)" || return $?
  assertEquals "$cleanHome/extra/dir/to/look" "$(userHome extra dir to look)" || return $?
  assertEquals "$cleanHome/extra/dir/to/look" "$(userHome extra/dir/to/look/)" || return $?

  mockEnvironmentStop HOME
}

testUserRecord() {
  assertExitCode --stdout-match "/root" 0 userRecord 6 root || return $?
  assertExitCode --stdout-match "/root" 0 userRecordHome root || return $?
  assertExitCode 0 userRecordName root || return $?
}
