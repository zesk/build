#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testBasicFileStuff)
tests+=(testBetterType)

testBasicFileStuff() {
  local testDir
  local testFile

  testDir=$(__environment mktemp -d) || return $?

  testFile="$testDir/$(randomString).$$"
  __environment touch "$testFile" || return $?
  assertExitCode 0 modificationTime "$testFile" || return $?
  assertExitCode 0 modificationSeconds "$testFile" || return $?
}

_assertBetterType() {
  assertEquals --line "$1" "$2" "$(betterType "$3")" "$2 != betterType $3 $(consoleRed "=> $(betterType "$3")")" || return $?
}

testBetterType() {
  _assertBetterType "$LINENO" "builtin" return || return $?
  _assertBetterType "$LINENO" "builtin" . || return $?
  _assertBetterType "$LINENO" "function" testBetterType || return $?
  _assertBetterType "$LINENO" "file" "${BASH_SOURCE[0]}" || return $?
  _assertBetterType "$LINENO" "directory" ../. || return $?
  _assertBetterType "$LINENO" "unknown" fairElections || return $?

  local d
  d=$(mktemp -d) || return $?
  requireDirectory "$d/food" >/dev/null || return $?
  ln -s "$d/food" "$d/food-link" || return $?

  touch "$d/goof" || return $?
  ln -s "$d/no-goof" "$d/no-goof-link" || return $?
  ln -s "$d/goof" "$d/goof-link" || return $?

  _assertBetterType "$LINENO" "directory" "$d/food" || return $?
  _assertBetterType "$LINENO" "link-directory" "$d/food-link" || return $?
  _assertBetterType "$LINENO" "file" "$d/goof" || return $?
  _assertBetterType "$LINENO" "link-unknown" "$d/no-goof-link" || return $?
  _assertBetterType "$LINENO" "link-file" "$d/goof-link" || return $?

  rm -rf "$d" || return $?
}
