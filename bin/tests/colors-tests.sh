#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(allColorTest)

tests+=(colorTest)

tests+=(testSimpleMarkdownToConsole)

testSimpleMarkdownToConsole() {
  local saveCI

  saveCI="${CI-}"
  export CI


  result="$(printf "%s text is %s and %s" "$(consoleCode Code)" "$(consoleCyan italic)" "$(consoleCyan bold)")"
  CI=
  # shellcheck disable=SC2016
  assertEquals "$(printf "%s" '`Code` text is *italic* and **bold**' | simpleMarkdownToConsole)" "$result"
  CI=1
  # shellcheck disable=SC2016
  assertEquals "$(printf "%s" '`Code` text is *italic* and **bold**' | simpleMarkdownToConsole)" "Code text is italic and bold"
  CI="$saveCI"
}
