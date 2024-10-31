#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(colorTest)
tests+=(allColorTest)

testSemanticColorTest() {
  local mode
  export BUILD_COLORS_MODE
  for mode in light dark; do
    BUILD_COLORS_MODE=$mode semanticColorTest
  done
  unset BUILD_COLORS_MODE
}

testSimpleMarkdownToConsole() {
  local saveBC actual expected testString
  local this=${FUNCNAME[0]}

  export BUILD_COLORS

  __environment buildEnvironmentLoad BUILD_COLORS || return $?

  saveBC=${BUILD_COLORS-}

  BUILD_COLORS=true

  # shellcheck disable=SC2016
  testString='`Code` text is *italic* and **bold**'

  expected="$(printf "%s text is %s and %s" "$(decorate code Code)" "$(decorate cyan italic)" "$(decorate red bold)")"

  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"

  assertEquals --line "$LINENO" "$expected" "$actual" "$this:$LINENO" || return $?

  BUILD_COLORS=false
  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"
  BUILD_COLORS="$saveBC"

  expected="Code text is italic and bold"
  assertEquals --line "$LINENO" "$actual" "$expected" || return $?
}

testColorComboTest() {
  echo "NOT BOLD"
  colorComboTest " ZESK "
  echo "BOLD"
  colorComboTest --bold " ZESK "
}
