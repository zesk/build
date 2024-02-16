#!/usr/bin/env bash
#
# log-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testLogFileRotate1)
tests+=(testLogFileRotate)
testLogFileRotate() {
  local tempDir section
  local count=5

  if ! tempDir=$(mktemp -d); then
    return $?
  fi

  n=1

  section=1
  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  assertFileDoesNotExist "$tempDir/test.log" || return $?
  rotateLog "$tempDir/test.log" "$count"

  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" "$count" || return $?

  # Not a file
  mkdir "$tempDir/test.log" || :
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" "$count" || return $?
  rmdir "$tempDir/test.log" || :

  # File now exists
  touch "$tempDir/test.log"
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" NOTINT || return $?
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" -423 || return $?
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" 0 || return $?

  # Remove for next test which should be clean
  rm "$tempDir/test.log" || return $?

  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  printf "%s" "$(repeat "$n" "x")" >"$tempDir/test.log" || return $?
  assertFileDoesNotExist "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileExists "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  consoleSuccess "SECTION $section"
  section=$((section + 1))

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileExists "$tempDir/test.log.4" || return $?
  assertFileExists "$tempDir/test.log.5" || return $?
  assertEquals "$(fileSize "$tempDir/test.log.5")" 1 "log $count was original log after $count rotations" || return $?
  assertEquals "$(fileSize "$tempDir/test.log.1")" 0 "log 1 is zero-sized" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  rm -rf "$tempDir" || return $?
}

testLogFileRotate1() {
  local tempDir count=1 i

  if ! tempDir=$(mktemp -d); then
    return $?
  fi

  i=1
  n=1
  assertExitCode 0 [ -d "$tempDir" ] || return $?
  assertFileDoesNotExist "$tempDir/test.log" || return $?

  printf "%s %s\n" "${FUNCNAME[0]}" "$i"
  i=$((i + 1))

  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" "$count" || return $?

  printf "%s %s\n" "${FUNCNAME[0]}" "$i"
  i=$((i + 1))

  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" NOTINT || return $?

  printf "%s %s\n" "${FUNCNAME[0]}" "$i"
  i=$((i + 1))

  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" -423 || return $?

  printf "%s %s\n" "${FUNCNAME[0]}" "$i"
  i=$((i + 1))

  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" 0 || return $?

  printf "%s %s\n" "${FUNCNAME[0]}" "$i"
  i=$((i + 1))

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
  assertEquals "$(fileSize "$tempDir/test.log")" 0 "log 0 was original log after $count rotations" || return $?
  assertEquals "$(fileSize "$tempDir/test.log.1")" 1 "log $count was original log after 1 rotation" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?

  i=10
  while [ "$i" -gt 0 ]; do
    if [ ! -d "$tempDir" ]; then
      consoleError "$tempDir got deleted i=$i" 1>&2
      return 1
    fi
    rotateLog "$tempDir/test.log" "$count" || return $?
    assertFileExists "$tempDir/test.log" || return $?
    assertFileExists "$tempDir/test.log.1" || return $?
    assertEquals "$(fileSize "$tempDir/test.log")" 0 || return $?
    assertEquals "$(fileSize "$tempDir/test.log.1")" 0 || return $?
    assertFileDoesNotExist "$tempDir/test.log.2" || return $?
    i=$((i - 1))
  done

  rm -rf "$tempDir" || return $?
}
