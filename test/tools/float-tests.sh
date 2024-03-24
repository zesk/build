#!/usr/bin/env bash
#
#  float-tests.sh
#
# docker tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testRoundFloat)

testRoundFloat() {
  local expected testValue
  _testRoundFloatData | while read -r expected testValue; do
    assertEquals "$expected" "$(roundFloat "$testValue")" "roundFloat $testValue" || return $?
  done
}

_testRoundFloatData() {
  cat <<'EOF'
100 99.99492993
0 0.4999999
0 0.5000000
1 0.5000001
2 1.6
3 2.9
10 9.8
11 11.1
EOF
}

testTruncateFloat() {
  local expected testValue
  _testTruncateFloatData | while read -r expected testValue; do
    assertEquals "$expected" "$(truncateFloat "$testValue")" "truncateFloat $testValue" || return $?
  done
}

_testTruncateFloatData() {
  cat <<'EOF'
99 99.99492993
0 0.4999999
0 0.5000000
0 0.5000001
1 1.6
2 2.9
9 9.8
11 11.1
EOF
}
