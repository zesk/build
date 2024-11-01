#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testAPITools() {
  assertEquals --line "$LINENO" "$(plural 0 singular plural)" "plural" || return $?
  assertEquals --line "$LINENO" "$(plural 1 singular plural)" "singular" || return $?
  assertEquals --line "$LINENO" "$(plural 2 singular plural)" "plural" || return $?
  assertEquals --line "$LINENO" "$(plural -1 singular plural)" "plural" || return $?
  assertExitCode --line "$LINENO" --stderr-ok 1 plural X singular plural || return $?

  assertEquals --line "$LINENO" "$(alignRight 20 012345)" "              012345" || return $?
  assertEquals --line "$LINENO" "$(alignRight 5 012345)" "012345" || return $?
  assertEquals --line "$LINENO" "$(alignRight 0 012345)" "012345" || return $?

  assertEquals --line "$LINENO" "$(dateToFormat 2023-04-20 %s)" "1681948800" || return $?
  assertEquals --line "$LINENO" "$(dateToFormat 2023-04-20 %Y-%m-%d)" "2023-04-20" || return $?
  assertEquals --line "$LINENO" "$(dateToTimestamp 2023-04-20)" "1681948800" || return $?
}

testHooks() {
  local h
  for h in deploy-cleanup deploy-confirm application-environment version-created version-live; do
    assertExitCode 0 hasHook $h || return $?
  done
  for h in misspelled-deployed-cleanup not-rude-confirm; do
    assertNotExitCode 0 hasHook $h || return $?
  done
  decorate success testHooks OK
}

testEnvironmentVariables() {
  assertOutputContains PWD environmentVariables || return $?
  assertOutputContains SHLVL environmentVariables || return $?
  assertOutputContains PATH environmentVariables || return $?
  assertOutputContains HOME environmentVariables || return $?
  assertOutputContains LANG environmentVariables || return $?
  assertOutputContains PWD environmentVariables || return $?
  decorate success testEnvironmentVariables OK || return $?
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

  # Convert to integer
  td=$((td + 0))
  tm=$((tm + 0))
  assertExitCode --line "$LINENO" 0 isInteger "$ty" || return $?
  assertExitCode --line "$LINENO" 0 isInteger "$tm" || return $?
  assertExitCode --line "$LINENO" 0 isInteger "$td" || return $?
  assertExitCode --line "$LINENO" 0 isInteger "$yy" || return $?
  assertExitCode --line "$LINENO" 0 isInteger "$ym" || return $?
  assertExitCode --line "$LINENO" 0 isInteger "$yd" || return $?

  # today 2024-01-01
  # yesterday 2023-12-31
  # Shell is AOK with `[ "02" -ge "01" ]` as integers
  assertGreaterThanOrEqual --line "$LINENO" "$ty" "$yy" || return $?
  if [ "$td" != 1 ]; then
    if [ "$tm" != 1 ]; then
      assertGreaterThanOrEqual --line "$LINENO" "$tm" "$ym" || return $?
    else
      assertGreaterThanOrEqual --line "$LINENO" "$ym" "$tm" || return $?
    fi
    assertGreaterThanOrEqual --line "$LINENO" "$td" "$yd" || return $?
  else
    assertGreaterThanOrEqual --line "$LINENO" "$yd" "$td" || return $?
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
  decorate success testMapPrefixSuffix OK
}
