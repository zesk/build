#!/usr/bin/env bash
#
# web-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testUrlContentLength() {
  assertEquals 56 "$(urlContentLength "https://marketacumen.com/zesk-build.html")" || return $?
}

testUrlFetch() {
  local handler="_return"
  local temp clean=()

  temp=$(fileTemporaryName "$handler") || return $?
  clean+=("$temp")
  assertExitCode --stdout-match "Test file for Zesk Build" --stdout-match "Hello, world." --stdout-match "<h1>" 0 urlFetch "https://marketacumen.com/zesk-build.html" "-" || returnClean $? "${clean[@]}" || return $?

  __catch "$handler" urlFetch "https://marketacumen.com/zesk-build.html" >"$temp" || returnClean $? "${clean[@]}" || return $?
  clean+=("$temp.1")
  __catch "$handler" urlFetch "https://marketacumen.com/zesk-build.html" - >"$temp.1" || returnClean $? "${clean[@]}" || return $?
  clean+=("$temp.2")
  __catch "$handler" urlFetch "https://marketacumen.com/zesk-build.html" "$temp.2" || returnClean $? "${clean[@]}" || return $?

  assertFileContains "$temp" "Test file for Zesk Build" || returnClean $? "${clean[@]}" || return $?

  __catchEnvironment "$handler" rm -f "${clean[@]}" || returnClean $? "${clean[@]}" || return $?
}
