#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testIsUpToDate() {
  local thisYear thisMonth expirationDays start testDate

  start=$(beginTiming)
  __testSection "isUpToDate testing"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"
  assertExitCode --line "$LINENO" --stderr-match "missing keyDate" 2 isUpToDate || return $?
  assertExitCode --line "$LINENO" --stderr-ok 2 isUpToDate "" || return $?
  assertExitCode --line "$LINENO" --stderr-ok 2 isUpToDate 99999 || return $?

  testDate=2020-01-01

  decorate info "2020: $testDate"

  assertNotExitCode --line "$LINENO" 0 isUpToDate $testDate 10 || return $?
  testDate="$thisYear-01-01"

  __testSection "ThisYear-01-01: $testDate"

  expirationDays=367
  assertNotExitCode --stderr-ok --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=366
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=365
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?

  __testSection "ThisYear-ThisMonth-01: $testDate"

  testDate="$thisYear-$thisMonth-01"
  expirationDays=60

  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?

  testDate=$(todayDate)

  __testSection "todayDate: $testDate"

  expirationDays=0
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?

  testDate=$(yesterdayDate)

  __testSection "yesterdayDate: $testDate"

  expirationDays=0
  assertNotExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?

  testDate=$(tomorrowDate)

  __testSection "tomorrowDate: $testDate"

  expirationDays=0
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?

  reportTiming "$start" Done
}
