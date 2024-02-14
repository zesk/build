#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
errorEnvironment=1

declare -a tests

tests+=(testTools)
testTools() {
  assertEquals "$(plural 0 singular plural)" "plural" || return $?
  assertEquals "$(plural 1 singular plural)" "singular" || return $?
  assertEquals "$(plural 2 singular plural)" "plural" || return $?
  assertEquals "$(plural -1 singular plural)" "plural" || return $?
  assertExitCode --stderr-ok 1 plural X singular plural || return $?

  assertEquals "$(alignRight 20 012345)" "              012345" || return $?
  assertEquals "$(alignRight 5 012345)" "012345" || return $?
  assertEquals "$(alignRight 0 012345)" "012345" || return $?

  assertEquals "$(dateToFormat 2023-04-20 %s)" "1681948800" || return $?
  assertEquals "$(dateToFormat 2023-04-20 %Y-%m-%d)" "2023-04-20" || return $?
  assertEquals "$(dateToTimestamp 2023-04-20)" "1681948800" || return $?
  consoleSuccess testTools OK
}

tests+=(testHooks)
testHooks() {
  for h in deploy-cleanup deploy-confirm make-env version-created version-live; do
    assertExitCode 0 hasHook $h || return $?
  done
  for h in misspelled-deployed-cleanup not-rude-confirm; do
    assertNotExitCode 0 hasHook $h || return $?
  done
  consoleSuccess testHooks OK
}

tests+=(testEnvironmentVariables)
testEnvironmentVariables() {
  assertOutputContains PWD environmentVariables || return $?
  assertOutputContains SHLVL environmentVariables || return $?
  assertOutputContains PATH environmentVariables || return $?
  assertOutputContains HOME environmentVariables || return $?
  assertOutputContains LANG environmentVariables || return $?
  assertOutputContains PWD environmentVariables || return $?
  consoleSuccess testEnvironmentVariables OK || return $?
}

tests+=(testDates)
testDates() {
  local t y
  assertEquals "$(timestampToDate 1697666075 %F)" "2023-10-18" || return $?
  assertEquals "$(todayDate)" "$(date +%F)" || return $?
  if ! t="$(todayDate)"; then
    consoleError todayDate failed
    return $errorEnvironment
  fi
  if ! y="$(yesterdayDate)"; then
    consoleError yesterdayDate failed
    return $errorEnvironment
  fi
  assertEquals "${#t}" "${#y}" || return $?

  if [[ "$y" < "$t" ]]; then
    consoleSuccess testDates OK
  else
    consoleError "$y \< $t" failed
    return $errorEnvironment
  fi
}

tests+=(testMapPrefixSuffix)
testMapPrefixSuffix() {
  local assertItem=1
  assertEquals "Hello, world." "$(echo "[NAME], [PLACE]." | NAME=Hello PLACE=world bin/build/map.sh --prefix '[' --suffix ']')" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh)" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAME PLACE)" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  assertEquals "Hello, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAME)" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  assertEquals "{NAME}, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh PLACE)" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAM PLAC)" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh AME LACE)" "#$assertItem failed" || return $?
  assertItem=$((assertItem + 1))
  consoleSuccess testMapPrefixSuffix OK
}
