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
    assertEquals "Ralph \"Dude\" Brown" "$(escapeSingleQuotes "Ralph \"Dude\" Brown")"
    assertEquals "Dude\\'s place" "$(escapeSingleQuotes "Dude's place")"
}
testEscapeDoubleQuotes() {
    assertEquals "Ralph \\\"Dude\\\" Brown" "$(escapeDoubleQuotes "Ralph \"Dude\" Brown")"
    assertEquals "Dude's place" "$(escapeDoubleQuotes "Dude's place")"
}

tests+=(testQuoteSedPattern)
testQuoteSedPattern() {
    assertEquals "\\[" "$(quoteSedPattern '[')"
    assertEquals "\\]" "$(quoteSedPattern ']')"
}

tests+=(testMapValue)
testMapValue() {
    tempEnv=$(mktemp)

    assertEquals "{foo}" "$(mapValue "$tempEnv" "{foo}")"

    printf "%s=%s\n" "foo" "bar" >>"$tempEnv"

    assertEquals "bar" "$(mapValue "$tempEnv" "{foo}")"

    rm "$tempEnv"
}
