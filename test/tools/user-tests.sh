#!/usr/bin/env bash
#
# user-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testUserHome() {
  __mockValue HOME

  export HOME

  HOME=/etc/does-not

  assertNotExitCode --dump --stderr-match "not a directory" --line "$LINENO" 0 userHome || return $?

  HOME=$(pwd)
  assertDirectoryExists "$HOME" || return $?
  assertExitCode --stdout-match "$HOME" --line "$LINENO" 0 userHome || return $?
  assertEquals --line "$LINENO" "$HOME" "$(userHome)" || return $?

  __mockValue HOME "" --end
}
