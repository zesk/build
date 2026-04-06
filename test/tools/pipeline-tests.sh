#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__assertVersionSort() {
  assertEquals "$(printf "%s\n" "$1" "$2")" "$(printf "%s\n" "$2" "$1" | textVersionSort)" || return $?
  assertEquals "$(printf "%s\n" "$1" "$2")" "$(printf "%s\n" "$1" "$2" | textVersionSort)" || return $?
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
  __testSection "decorate expired testing: BUILD_DEBUG=${BUILD_DEBUG-}"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"
  assertExitCode --stderr-match "missing keyDate" 2 decorate expired || return $?
  assertExitCode --stderr-ok 2 decorate expired "" || return $?
  assertExitCode --stderr-ok 2 decorate expired 99999 || return $?

  testDate=2020-01-01

  decorate info "2020: $testDate"

  assertNotExitCode 0 decorate expired $testDate 10 || return $?
  testDate="$thisYear-01-01"

  __testSection "ThisYear-01-01: $testDate"

  expirationDays=367
  assertNotExitCode --stderr-ok --line "$LINENO" 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=366
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=365
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?

  __testSection "ThisYear-ThisMonth-01: $testDate"

  testDate="$thisYear-$thisMonth-01"
  expirationDays=60

  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?

  testDate=$(dateToday)

  __testSection "dateToday: $testDate"

  expirationDays=0
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?

  testDate=$(dateYesterday)

  __testSection "dateYesterday: $testDate"

  expirationDays=0
  assertNotExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?

  testDate=$(dateTomorrow)

  __testSection "dateTomorrow: $testDate"

  expirationDays=0
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=1
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?
  expirationDays=2
  assertExitCode 0 decorate expired "$testDate" "$expirationDays" || return $?

  timingReport "$start" Done
}
