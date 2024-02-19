#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testRepeat)
testRepeat() {
  assertEquals "$(repeat 10 "x")" "xxxxxxxxxx" || return $?
  assertEquals "$(repeat 11 "x")" "xxxxxxxxxxx" || return $?
  assertEquals "$(repeat 1 "x")" "x" || return $?
  assertEquals "$(repeat 0 "x")" "" || return $?
}

tests+=(testAlignRight)
testAlignRight() {
  assertEquals "$(alignRight 10 "Dogmatic")" "  Dogmatic" || return $?
  assertEquals "$(alignRight 10 "")" "          " || return $?
  assertEquals "$(alignRight 2 "Dogmatic")" "Dogmatic" || return $?
  assertEquals "$(alignRight 2 "")" "  " || return $?
}
tests+=(testAlignLeft)
testAlignLeft() {
  assertEquals "$(alignLeft 10 "Dogmatic")" "Dogmatic  " || return $?
  assertEquals "$(alignLeft 10 "")" "          " || return $?
  assertEquals "$(alignLeft 2 "Dogmatic")" "Dogmatic" || return $?
  assertEquals "$(alignLeft 2 "")" "  " || return $?
}

tests+=(testRepeat2)
testRepeat2() {
  local expected

  expected="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  for n in $(seq 1 ${#expected}); do
    assertEquals "${expected:0:$n}" "$(repeat "$n" x)" "Failed to match repeat $n" || return $?
  done
}
