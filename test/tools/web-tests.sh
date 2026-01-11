#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# web-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testUrlContentLength() {
  assertEquals 56 "$(urlContentLength "https://marketacumen.com/zesk-build.html")" || return $?
}

testUrlFetch() {
  local handler="returnMessage"
  local temp clean=()

  local remoteURL

  remoteURL="https://marketacumen.com/zesk-build.html"

  temp=$(fileTemporaryName "$handler") || return $?
  clean+=("$temp")
  local mm=(--stdout-match "Test file for Zesk Build" --stdout-match "Hello, world.")

  catchReturn "$handler" urlFetch --debug "$remoteURL" || returnClean $? "${clean[@]}" || return $?
  assertExitCode "${mm[@]}" 0 urlFetch "$remoteURL" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" urlFetch "$remoteURL" >"$temp" || returnClean $? "${clean[@]}" || return $?

  clean+=("$temp.1")

  catchReturn "$handler" urlFetch "$remoteURL" >"$temp.1" || returnClean $? "${clean[@]}" || return $?

  clean+=("$temp.2")

  catchReturn "$handler" urlFetch "$remoteURL" "$temp.2" || returnClean $? "${clean[@]}" || return $?

  assertEquals "$(cat "$temp.1")" "$(cat "$temp.2")" || return $?

  assertExitCode 0 urlMatchesLocalFileSize "$remoteURL" "$temp" || return $?

  assertFileContains "$temp" "Test file for Zesk Build" || returnClean $? "${clean[@]}" || return $?

  catchEnvironment "$handler" rm -f "${clean[@]}" || returnClean $? "${clean[@]}" || return $?
}
