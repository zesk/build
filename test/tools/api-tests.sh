#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testAPITools() {
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

testHooks() {
  local h
  for h in deploy-cleanup deploy-confirm application-environment version-created version-live; do
    assertExitCode 0 hasHook $h || return $?
  done
  for h in misspelled-deployed-cleanup not-rude-confirm; do
    assertNotExitCode 0 hasHook $h || return $?
  done
  consoleSuccess testHooks OK
}

testEnvironmentVariables() {
  assertOutputContains PWD environmentVariables || return $?
  assertOutputContains SHLVL environmentVariables || return $?
  assertOutputContains PATH environmentVariables || return $?
  assertOutputContains HOME environmentVariables || return $?
  assertOutputContains LANG environmentVariables || return $?
  assertOutputContains PWD environmentVariables || return $?
  consoleSuccess testEnvironmentVariables OK || return $?
}

testDates() {
  local t y ty tm td yy ym yd
  assertEquals --line "$LINENO" "$(timestampToDate 1697666075 %F)" "2023-10-18" || return $?
  assertEquals --line "$LINENO" "$(todayDate)" "$(date +%F)" || return $?

  t="$(todayDate)" || _environment todayDate failed || return $?
  y="$(yesterdayDate)" || _environment yesterdayDate failed || return $?

  assertEquals "${#t}" "${#y}" || return $?

  IFS="-" read -r ty tm td <<<"$t"
  IFS="-" read -r yy ym yd <<<"$y"

  # today 2024-01-01
  # yesterday 2023-12-31
  # Shell is AOK with `[ "02" -ge "01" ]` as integers
  assertGreaterThanOrEqual --line "$LINENO" "$ty" "$yy" || return $?
  if [ "$td" != 1 ]; then
    if [ "$tm" != 1 ]; then
      assertGreaterThanOrEqual --line "$LINENO" "$tm" "$ym" || return $?
    fi
    assertGreaterThanOrEqual --line "$LINENO" "$td" "$yd" || return $?
  fi
}

testMapPrefixSuffix() {
  local itemIndex=1
  assertEquals "Hello, world." "$(echo "[NAME], [PLACE]." | NAME=Hello PLACE=world bin/build/map.sh --prefix '[' --suffix ']')" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh)" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAME PLACE)" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  assertEquals "Hello, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAME)" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  assertEquals "{NAME}, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh PLACE)" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAM PLAC)" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh AME LACE)" "#$itemIndex failed" || return $?
  itemIndex=$((itemIndex + 1))
  consoleSuccess testMapPrefixSuffix OK
}
