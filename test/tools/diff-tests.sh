#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# diff-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testFilesAreIdentical() {
  local handler="returnMessage"

  local temp && temp=$(fileTemporaryname "$handler") || return $?

  catchEnvironment "$handler" printf "%s\n" "abc " "def " "ghi " "jkl " "mno " "pqr " "tuv" "wxy " "z   " >"$temp" || return $?

  catchEnvironment "$handler" cp "$temp" "$temp.same" || return $?
  catchEnvironment "$handler" textTrim <"$temp" >"$temp.trim" || return $?

  # shellcheck disable=SC2094
  assertExitCode 0 filesAreIdentical "$temp" - <"$temp" || return $?

  assertExitCode 0 filesAreIdentical "$temp" - <"$temp.same" || return $?
  assertExitCode 0 filesAreIdentical "$temp" "$temp.same" || return $?
  assertExitCode 0 filesAreIdentical - "$temp.same" <"$temp" || return $?

  assertExitCode 1 filesAreIdentical "$temp" "$temp.trim" || return $?
  assertExitCode 1 filesAreIdentical "$temp" - <"$temp.trim" || return $?
  assertExitCode 1 filesAreIdentical - "$temp.trim" <"$temp" || return $?

  assertExitCode 1 filesAreIdentical -b "$temp" "$temp.trim" || return $?
  assertExitCode 1 filesAreIdentical -b"$temp" - <"$temp.trim" || return $?
  assertExitCode 1 filesAreIdentical -b - "$temp.trim" <"$temp" || return $?

  catchEnvironment "$handler" rm "$temp" || return $?
}
