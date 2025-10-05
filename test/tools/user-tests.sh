#!/usr/bin/env bash
#
# user-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testUserHome() {
  export HOME

  mockEnvironmentStart HOME "${HOME-}"

  HOME=/etc/does-not

  assertNotExitCode --dump --stderr-match "not a directory" --line "$LINENO" 0 userRecordHome || return $?

  HOME=$(pwd)

  local cleanHome

  cleanHome="${HOME%/}"
  assertDirectoryExists "$HOME" || return $?
  assertExitCode --stdout-match "$cleanHome" --line "$LINENO" 0 userRecordHome || return $?
  assertEquals "$cleanHome" "$(userRecordHome)" || return $?
  assertEquals "$cleanHome/extra" "$(userRecordHome extra)" || return $?
  assertEquals "$cleanHome/extra/dir/to/look" "$(userRecordHome extra dir to look)" || return $?
  assertEquals "$cleanHome/extra/dir/to/look" "$(userRecordHome extra/dir/to/look/)" || return $?

  mockEnvironmentStop HOME
}
