#!/usr/bin/env bash
#
# date-tests.sh
#
# Date tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__testDateValidData() {
  cat <<EOF
1900-01-01
2000-12-23
1992-09-22
2020-01-22
EOF
}

__testDateInvalidData() {
  cat <<EOF
1900:01-01
2000-13-23
1992-09-32
1500-01-22
19-23-42
0000-00-00
EOF
}

testDateValid() {
  while read -r testDate; do
    assertExitCode 0 dateValid "$testDate" || return $?
  done < <(__testDateValidData)
  while read -r testDate; do
    assertNotExitCode --stderr-ok 0 dateValid "$testDate" || return $?
  done < <(__testDateInvalidData)
}

testDateAdd() {
  assertEquals "2024-12-31" "$(dateAdd --days -1 "2025-01-01")" || return $?
  assertEquals "2024-12-30" "$(dateAdd --days -2 "2025-01-01")" || return $?
  assertEquals "2025-03-01" "$(dateAdd "2025-02-28")" || return $?
  assertEquals "2025-03-01" "$(dateAdd --days 1 "2025-02-28")" || return $?
  assertEquals "2025-02-28" "$(dateAdd --days 0 "2025-02-28")" || return $?
  assertEquals "2024-02-29" "$(dateAdd --days -365 "2025-02-28")" || return $?
}
