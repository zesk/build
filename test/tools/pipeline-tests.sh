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
testDecorateExpired() {
  BUILD_DEBUG=handler __testExpirationFunction decorate expired || return $?
}

# Tag: slow
testDateWithinDays() {
  __testExpirationFunction dateWithinDays || return $?
}

__testExpirationFunction() {
  local start && start=$(timingStart)
  __testSection "$*: BUILD_DEBUG=${BUILD_DEBUG-}"
  local thisYear && thisYear=$(($(date +%Y) + 0))
  local thisMonth && thisMonth="$(date +%m)"
  assertExitCode --stderr-match "Date" 2 "$@" || return $?
  assertExitCode --stderr-ok 2 "$@" "" || return $?
  assertExitCode --stderr-ok 2 "$@" 99999 || return $?

  local testDate="2020-01-01"

  decorate info "$*: $testDate"

  assertNotExitCode --stderr-ok 0 "$@" $testDate 10 || return $?
  testDate="$thisYear-01-01"

  __testSection "$*: ThisYear-01-01: $testDate"

  local expirationDays && for expirationDays in 367 366 365 3650; do
    assertExitCode 0 "$@" "$testDate" "$expirationDays" || return $?
  done
  __testSection "$*: ThisYear-ThisMonth-01: $testDate"

  testDate="$thisYear-$thisMonth-01"
  expirationDays=60
  assertExitCode 0 "$@" "$testDate" "$expirationDays" || return $?

  local returnCode=1 ss=(--stderr-ok)
  for testDate in "$(dateYesterday)" "$(dateToday)" $(dateTomorrow); do
    __testSection "$testDate"
    for expirationDays in 0 1 2; do
      assertExitCode "${ss[@]+"${ss[@]}"}" "$returnCode" "$@" "$testDate" "$expirationDays" || return $?
      returnCode=0
      ss=()
    done
  done
  timingReport "$start" "$* Done"
}
