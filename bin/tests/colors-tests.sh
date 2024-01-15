#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

export BUILD_COLORS

declare -a tests

tests+=(testSimpleMarkdownToConsole)

testSimpleMarkdownToConsole() {
  local saveBC actual expected testString

  saveBC=${BUILD_COLORS-}

  # shellcheck disable=SC2016
  testString='`Code` text is *italic* and **bold**'

  expected="$(printf "%s text is %s and %s" "$(consoleCode Code)" "$(consoleCyan italic)" "$(consoleRed bold)")"

  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"

  assertEquals "$actual" "$expected" || return $?

  BUILD_COLORS=
  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"
  BUILD_COLORS="$saveBC"

  expected="Code text is italic and bold"

  echo "EXPECTED:"
  echo "$expected" | xxd
  echo "ACTUAL:"
  echo "$actual" | xxd
  assertEquals "$actual" "$expected" || return $?
}

tests+=(allColorTest)

tests+=(colorTest)
