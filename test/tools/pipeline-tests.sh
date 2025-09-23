#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__assertVersionSort() {
  assertEquals "$(printf "%s\n" "$1" "$2")" "$(printf "%s\n" "$2" "$1" | versionSort)" || return $?
  assertEquals "$(printf "%s\n" "$1" "$2")" "$(printf "%s\n" "$1" "$2" | versionSort)" || return $?
}
testVersionSort() {
  __assertVersionSort "v1.2.3" "v1.2.4" || return $?
  __assertVersionSort "v1.2.3" "v1.2.3" || return $?
  __assertVersionSort "v1.2.3" "v1.3.3" || return $?
  __assertVersionSort "v1.2.3" "v2.1.3" || return $?
  __assertVersionSort "v100.100.100" "v100.100.1001" || return $?
  __assertVersionSort "v100.100.100" "v100.101.0" || return $?
  __assertVersionSort "v100.100.100" "v101.0.0" || return $?
  __assertVersionSort "v100.100.100" "v1000.100.100" || return $?
}

# Tag: slow
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
