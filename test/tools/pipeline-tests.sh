#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#


_uptoDateTest() {
  local pass=$1

  shift
  if [ "$pass" = "1" ]; then
    if ! isUpToDate "$@"; then
      _environment "isUpToDate $* should be up to date" || return $?
    fi
  else
    if isUpToDate "$@"; then
      _environment  "isUpToDate $* should NOT be up to date" || return $?
    fi
  fi
}


testIsUpToDate() {
  local thisYear thisMonth expirationDays start testDate

  start=$(beginTiming)
  __testSection "isUpToDate testing"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"
  _uptoDateTest 0 || return $?
  _uptoDateTest 0 "" || return $?
  _uptoDateTest 0 99999 || return $?

  testDate=2020-01-01

  decorate info "2020: $testDate"

  _uptoDateTest 0 $testDate 10 || return $?
  testDate="$thisYear-01-01"

  __testSection "ThisYear-01-01: $testDate"

  expirationDays=367
  _uptoDateTest 0 "$testDate" "$expirationDays" || return $?
  expirationDays=366
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=365
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  __testSection "ThisYear-ThisMonth-01: $testDate"

  testDate="$thisYear-$thisMonth-01"
  expirationDays=60

  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testDate=$(todayDate)

  __testSection "todayDate: $testDate"

  expirationDays=0
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=1
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=2
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testDate=$(yesterdayDate)

  __testSection "yesterdayDate: $testDate"

  expirationDays=0
  _uptoDateTest 0 "$testDate" "$expirationDays" || return $?
  expirationDays=1
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=2
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testDate=$(tomorrowDate)

  __testSection "tomorrowDate: $testDate"

  expirationDays=0
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=1
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=2
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  reportTiming "$start" Done
}
