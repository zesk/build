#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# decoration-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testRepeat() {
  assertEquals "$(textRepeat 10 "@")" "@@@@@@@@@@" || return $?
  assertEquals "$(textRepeat 11 "!")" "!!!!!!!!!!!" || return $?
  assertEquals "$(textRepeat 1 "x")" "x" || return $?
  assertEquals "$(textRepeat 0 "x")" "" || return $?
}

testAlignRight() {
  assertEquals "$(textAlignRight 10 "Dogmatic")" "  Dogmatic" || return $?
  assertEquals "$(textAlignRight 10 "")" "          " || return $?
  assertEquals "$(textAlignRight 2 "Dogmatic")" "Dogmatic" || return $?
  assertEquals "$(textAlignRight 2 "")" "  " || return $?
}
testAlignLeft() {
  assertEquals "$(textAlignLeft 10 "Dogmatic")" "Dogmatic  " || return $?
  assertEquals "$(textAlignLeft 10 "")" "          " || return $?
  assertEquals "$(textAlignLeft 2 "Dogmatic")" "Dogmatic" || return $?
  assertEquals "$(textAlignLeft 2 "")" "  " || return $?
}

testRepeat2() {
  local string=".................."
  local n

  n=0
  while [ "$n" -lt ${#string} ]; do
    assertEquals "${string:0:$n}" "$(textRepeat "$n" .)" "Failed to match textRepeat $n" || return $?
    n=$((n + 1))
  done
}

testLabeledBigText() {
  assertOutputContains "foo" labeledBigText --top foo bar || return $?
  assertOutputContains "foo" labeledBigText --bottom foo bar || return $?
}

testBoxedHeading() {
  local header="A really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, really, long string which should likely be longer than any console or testing window that would likely be available at any point in the near or potential future which may have longer text widths perhaps even more than a few hundred. Waldo"
  assertExitCode --stdout-match "A really, really" --stdout-no-match Waldo 0 consoleHeadingBoxed "$header" || return $?
  assertExitCode --stdout-match "A really, really" --stdout-no-match Waldo 0 consoleHeadingBoxed --size 10 "$header" || return $?
  assertExitCode --stdout-match "A really, really" --stdout-no-match Waldo 0 consoleHeadingBoxed --shrink 20 "$header" || return $?
}
