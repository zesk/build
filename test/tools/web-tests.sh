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
  local usage="_return"
  local temp

  temp=$(fileTemporaryName "$usage") || return $?

  assertExitCode --stdout-match "Test file for Zesk Build" --stdout-match "Hello, world." --stdout-match "<h1>" 0 urlFetch "https://marketacumen.com/zesk-build.html" "-" || return $?

  __catchEnvironment "$usage" rm -f "$temp" || return $?
}
