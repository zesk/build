#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testSimpleMarkdownToConsole)
tests+=(testColorComboTest)
tests+=(colorTest)
tests+=(allColorTest)

testSimpleMarkdownToConsole() {
  local saveBC actual expected testString
  local this=${FUNCNAME[0]}

  export BUILD_COLORS

  __environment buildEnvironmentLoad BUILD_COLORS || return $?

  saveBC=${BUILD_COLORS-}

  BUILD_COLORS=true

  # shellcheck disable=SC2016
  testString='`Code` text is *italic* and **bold**'

  expected="$(printf "%s text is %s and %s" "$(consoleCode Code)" "$(consoleCyan italic)" "$(consoleRed bold)")"

  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"

  assertEquals --line "$LINENO" "$expected" "$actual" "$this:$LINENO" || return $?

  BUILD_COLORS=false
  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"
  BUILD_COLORS="$saveBC"

  expected="Code text is italic and bold"

#  aptInstall xxd || return $?
#
#  echo "EXPECTED:"
#  echo "$expected" | xxd
#  echo "ACTUAL:"
#  echo "$actual" | xxd
#
  assertEquals --line "$LINENO" "$actual" "$expected" || return $?
}

testColorComboTest() {
  colorComboTest " ZB "
}
