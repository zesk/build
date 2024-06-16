#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/env/BUILD_COLORS.sh"

declare -a tests

tests+=(testSimpleMarkdownToConsole)

testSimpleMarkdownToConsole() {
  local saveBC actual expected testString
  local this=${FUNCNAME[0]}

  saveBC=${BUILD_COLORS-}

  # shellcheck disable=SC2016
  testString='`Code` text is *italic* and **bold**'

  expected="$(printf "%s text is %s and %s" "$(consoleCode Code)" "$(consoleCyan italic)" "$(consoleRed bold)")"

  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"

  assertEquals "$expected" "$actual" "$this:$LINENO" || return $?

  BUILD_COLORS=
  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"
  BUILD_COLORS="$saveBC"

  expected="Code text is italic and bold"

  aptInstall xxd || return $?

  echo "EXPECTED:"
  echo "$expected" | xxd
  echo "ACTUAL:"
  echo "$actual" | xxd

  assertEquals "$actual" "$expected" || return $?
}

testColorComboTest() {
  colorComboTest " ZB "
}

tests+=(testColorComboTest)

tests+=(colorTest)

tests+=(allColorTest)
