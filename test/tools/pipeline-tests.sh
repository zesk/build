#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIsUpToDate() {
  local thisYear thisMonth expirationDays start testDate

  start=$(timingStart)
  __testSection "isUpToDate testing: BUILD_DEBUG=${BUILD_DEBUG-}"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"
  assertExitCode --stderr-match "missing keyDate" 2 isUpToDate || return $?
  assertExitCode --stderr-ok 2 isUpToDate "" || return $?
  assertExitCode --stderr-ok 2 isUpToDate 99999 || return $?

  testDate=2020-01-01

  decorate info "2020: $testDate"

  assertNotExitCode 0 isUpToDate $testDate 10 || return $?
  testDate="$thisYear-01-01"

  __testSection "ThisYear-01-01: $testDate"

  expirationDays=367
  assertNotExitCode --stderr-ok --line "$LINENO" 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=366
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=365
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?

  __testSection "ThisYear-ThisMonth-01: $testDate"

  testDate="$thisYear-$thisMonth-01"
  expirationDays=60

  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?

  testDate=$(todayDate)

  __testSection "todayDate: $testDate"

  expirationDays=0
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?

  testDate=$(yesterdayDate)

  __testSection "yesterdayDate: $testDate"

  expirationDays=0
  assertNotExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?

  testDate=$(tomorrowDate)

  __testSection "tomorrowDate: $testDate"

  expirationDays=0
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode 0 isUpToDate "$testDate" "$expirationDays" || return $?

  timingReport "$start" Done
}
