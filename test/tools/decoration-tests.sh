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
  assertEquals "$(repeat 10 printf "x")" "xxxxxxxxxx"
}

tests+=(testAlignRight)
testAlignRight() {
  assertEquals "$(alignRight 10 "Dogmatic")" "   Dogmatic"
  assertEquals "$(alignRight 10 "")" "           "
  assertEquals "$(alignRight 2 "Dogmatic")" "Dogmatic"
  assertEquals "$(alignRight 2 "")" "  "
}
tests+=(testAlignLeft)
testAlignLeft() {
  assertEquals "$(alignRight 10 "Dogmatic")" "Dogmatic   "
  assertEquals "$(alignRight 10 "")" "           "
  assertEquals "$(alignRight 2 "Dogmatic")" "Dogmatic"
  assertEquals "$(alignRight 2 "")" "  "
}
