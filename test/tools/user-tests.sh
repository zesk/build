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
