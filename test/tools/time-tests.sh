#!/usr/bin/env bash
#
# time-tests.sh
#
# Time tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__testTimingData() {
  cat <<"EOF"
0 0
1 1000
2 2000
1.001 1001
1.02 1020
1.3 1300
1.9 1900
1.234 1234
54.512 54512
EOF
}

testTiming() {
  local foo

  foo=$(timingStart)
  assertExitCode 0 timingStart || return $?
  assertExitCode 0 isUnsignedInteger "$foo" || return $?

  local expected actual
  while read -r expected actual; do
    assertEquals "$expected" "$(timingFormat "$actual")" || return $?
  done < <(__testTimingData)
}
