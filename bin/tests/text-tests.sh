#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

declare -a tests

tests+=(testText)
testText() {
    assertOutputContains Hello boxedHeading Hello
}

tests+=(testEscapeSingleQuotes)
testEscapeSingleQuotes() {
    assertEquals "Dude\\'s place" "$(escapeSingleQuotes "Dude's place")"
}

tests+=(testQuoteSedPattern)
testQuoteSedPattern() {
    assertEquals "\\[" "$(quoteSedPattern '[')"
    assertEquals "\\]" "$(quoteSedPattern ']')"
}
