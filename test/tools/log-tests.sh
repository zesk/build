#!/usr/bin/env bash
#
# identical-tests.sh
#
# identical tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testLogFileRotate)
testLogFileRotate() {
  local tempDir
  local count=5
  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #
  if ! tempDir=$(mktemp -d); then
    return $?
  fi

  n=1

  assertFileDoesNotExist "$tempDir/test.log" || return $?

  assertNotExitCode 0 rotateLog "$tempDir/test.log" "$count"
  assertNotExitCode 0 rotateLog "$tempDir/test.log" NOTINT
  assertNotExitCode 0 rotateLog "$tempDir/test.log" -423
  assertNotExitCode 0 rotateLog "$tempDir/test.log" 0

  rotateLog "$tempDir/test.log" "$count" || return $?

  printf "%s" "$(repeat "$n" "x")" >"$tempDir/test.log" || return $?
  assertFileDoesNotExist "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileExists "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileExists "$tempDir/test.log.4" || return $?
  assertFileExists "$tempDir/test.log.5" || return $?
  assertEquals "$(fileSize "$tempDir/test.log.5")" 1 "log $count was original log after $count rotations"
  assertEquals "$(fileSize "$tempDir/test.log.1")" 0 "log 1 is zero-sized"
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rm -rf "$tempDir" || return $?
}

tests+=(testLogFileRotate1)
testLogFileRotate1() {
  local tempDir count=1 i
  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #
  if ! tempDir=$(mktemp -d); then
    return $?
  fi

  n=1

  assertFileDoesNotExist "$tempDir/test.log" || return $?

  assertNotExitCode 0 rotateLog "$tempDir/test.log" "$count"
  assertNotExitCode 0 rotateLog "$tempDir/test.log" NOTINT
  assertNotExitCode 0 rotateLog "$tempDir/test.log" -423
  assertNotExitCode 0 rotateLog "$tempDir/test.log" 0

  rotateLog "$tempDir/test.log" "$count" || return $?

  printf "%s" "$(repeat "$n" "x")" >"$tempDir/test.log" || return $?
  assertFileDoesNotExist "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertEquals "$(fileSize "$tempDir/test.log")" 0 "log 0 was original log after $count rotations"
  assertEquals "$(fileSize "$tempDir/test.log.1")" 1 "log $count was original log after 1 rotation"
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?

  i=10
  while [ "$i" -gt 0 ]; do
    rotateLog "$tempDir/test.log" "$count" || return $?
    assertFileExists "$tempDir/test.log" || return $?
    assertFileExists "$tempDir/test.log.1" || return $?
    assertEquals "$(fileSize "$tempDir/test.log")" 0
    assertEquals "$(fileSize "$tempDir/test.log.1")" 0
    assertFileDoesNotExist "$tempDir/test.log.2" || return $?
    i=$((i - 1))
  done

  rm -rf "$tempDir" || return $?
}
