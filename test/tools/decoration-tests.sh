#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

testRepeat() {
  assertEquals "$(repeat 10 "x")" "xxxxxxxxxx" || return $?
  assertEquals "$(repeat 11 "x")" "xxxxxxxxxxx" || return $?
  assertEquals "$(repeat 1 "x")" "x" || return $?
  assertEquals "$(repeat 0 "x")" "" || return $?
}

testAlignRight() {
  assertEquals "$(alignRight 10 "Dogmatic")" "  Dogmatic" || return $?
  assertEquals "$(alignRight 10 "")" "          " || return $?
  assertEquals "$(alignRight 2 "Dogmatic")" "Dogmatic" || return $?
  assertEquals "$(alignRight 2 "")" "  " || return $?
}
testAlignLeft() {
  assertEquals "$(alignLeft 10 "Dogmatic")" "Dogmatic  " || return $?
  assertEquals "$(alignLeft 10 "")" "          " || return $?
  assertEquals "$(alignLeft 2 "Dogmatic")" "Dogmatic" || return $?
  assertEquals "$(alignLeft 2 "")" "  " || return $?
}

testRepeat2() {
  local string
  local n
  string="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

  n=0
  while [ "$n" -lt ${#string} ]; do
    assertEquals "${string:0:$n}" "$(repeat "$n" x)" "Failed to match repeat $n" || return $?
    n=$((n + 1))
  done
}

testLabeledBigText() {
  assertOutputContains "foo" labeledBigText --top foo bar || return $?
  assertOutputContains "foo" labeledBigText --bottom foo bar || return $?
}

tests+=(testRepeat)
tests+=(testAlignRight)
tests+=(testAlignLeft)
tests+=(testRepeat2)
tests+=(testLabeledBigText)
