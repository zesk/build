#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testIsAbsolutePath)
tests+=(testRequireFileDirectory)
tests+=(testFileDirectoryExists)

testIsAbsolutePath() {
  local path exitCode

  __testIsAbsolutePathData | while IFS=, read -r path exitCode; do
    assertExitCode --line "$LINENO" "$exitCode" isAbsolutePath "$path" || return $?
  done
}

testRequireFileDirectory() {
  assertDirectoryNotExists temp || return $?
  assertExitCode 0 requireFileDirectory temp || return $?
  assertDirectoryExists temp || return $?
  assertExitCode 0 rm -rf temp || return $?
}

testFileDirectoryExists() {
  assertExitCode 0 fileDirectoryExists "${BASH_SOURCE[0]}}" || return $?
  assertNotExitCode 0 fileDirectoryExists "${BASH_SOURCE[0]}}/not-a-dir" || return $?
}
