#!/usr/bin/env bash
#
# log-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testLogFileRotate() {
  local tempDir
  local count=5 n
  local name="${FUNCNAME[0]}"

  if ! tempDir=$(mktemp -d); then
    return $?
  fi

  n=1

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

  assertFileDoesNotExist "$tempDir/test.log" || return $?

  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" "$count" || return $?

  decorate success "$(clearLine)SECTION $(incrementor "$name")"
  # Not a file
  mkdir "$tempDir/test.log" || :
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" "$count" || return $?
  rm -rf "$tempDir/test.log/" || :

  decorate success "$(clearLine)SECTION $(incrementor "$name")"
  # File now exists
  touch "$tempDir/test.log"
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" NOTINT || return $?
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" -423 || return $?
  assertNotExitCode --stderr-ok 0 rotateLog "$tempDir/test.log" 0 || return $?

  # Remove for next test which should be clean
  rm "$tempDir/test.log" || return $?

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

  printf "%s" "$(repeat "$n" "x")" >"$tempDir/test.log" || return $?
  assertFileDoesNotExist "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileDoesNotExist "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileDoesNotExist "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileDoesNotExist "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

  rotateLog "$tempDir/test.log" "$count" || return $?
  assertFileExists "$tempDir/test.log" || return $?
  assertFileExists "$tempDir/test.log.1" || return $?
  assertFileExists "$tempDir/test.log.2" || return $?
  assertFileExists "$tempDir/test.log.3" || return $?
  assertFileExists "$tempDir/test.log.4" || return $?
  assertFileDoesNotExist "$tempDir/test.log.5" || return $?
  assertFileDoesNotExist "$tempDir/test.log.6" || return $?

  #-----------------------------------------------------------------------------------------
  decorate success "$(clearLine)SECTION $(incrementor "$name")"

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

  printf "\n"
  bigText "$name OK"
}

testLogFileRotate1() {
  local tempDir count=1 i n

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
      decorate error "$tempDir got deleted i=$i" 1>&2
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
