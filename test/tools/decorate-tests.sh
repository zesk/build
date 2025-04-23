#!/usr/bin/env bash
#
# decorate-tests.sh
#
# Darwin tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testDecorateStdin() {
  assertExitCode 0 decorate green || return $?
  assertEquals "$(printf "%s\n" "Something notable and prescient" "Leader" | decorate quote)" "\"Something notable and prescient\""$'\n'"\"Leader\"" || return $?
}

testDecorateBasics() {
  local color actual expected inVersion

  local phrase="Bird, bird. bird is the word."

  for color in red yellow green blue; do
    actual="$(decorate "$color" --)Bird, bird. bird is the word.$(decorate reset --)"
    expected="$(decorate "$color" "$phrase")"
    inVersion="$(decorate "$color" <<<"$phrase")"
    if ! assertEquals "$expected" "$actual"; then
      dumpBinary "Expected" <<<"$expected"
      dumpBinary "Actual" <<<"$actual"
      return 1
    fi
    if ! assertEquals "$expected" "$inVersion"; then
      dumpBinary "(stdin) Expected" <<<"$expected"
      dumpBinary "(stdin) Actual" <<<"$actual"
      return 1
    fi
  done
}

testDecorateArgs() {
  local reset

  reset=$(printf -- '\e[0m')
  assertEquals "$(decorate reset --)" "$reset" || return $?
}
