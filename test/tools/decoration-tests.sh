#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

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
  string="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

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

testBoxedHeading() {
  local header="A really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, long string which should likely be longer than any console or testing window that would likely be available at any point in the near or potential future which may have longer text widths perhaps even more than a few hundred. Waldo"
  assertExitCode --stdout-match "A really, really" --stdout-no-match Waldo 0 boxedHeading "$header" || return $?
  assertExitCode --stdout-match "A really, really" --stdout-no-match Waldo 0 boxedHeading --size 10 "$header" || return $?
  assertExitCode --stdout-match "A really, really" --stdout-no-match Waldo 0 boxedHeading --shrink 20 "$header" || return $?
}
