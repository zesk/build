#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

tests+=(testSugar)
testSugar() {
  local code

  assertEquals "$(printf "Hello\n- a\n- b\n- c\n- d e\n")" "$(_list "Hello" "a" "b" "c" "d e")" || return $?

  # _exit
  assertEquals "99" "$( (_exit) || echo $?)" || return $?

  # _return
  for code in $(seq 0 127); do
    assertExitCode --stderr-ok "$code" _return "$code" || return $?
  done
  # _environment
  # _argument
  assertExitCode --stderr-ok 1 _environment || return $?
  assertExitCode --stderr-ok 2 _argument || return $?

  assertExitCode --stderr-ok 1 _environment 1 2 3 || return $?
  assertExitCode --stderr-ok 2 _argument a b c || return $?

  # __execute
  assertExitCode --stderr-match foo 1 __execute _environment "foo" || return $?
  assertExitCode --stderr-match foo 2 __execute _argument "foo" || return $?
  # __echo
  assertExitCode --stdout-match "Running: printf %s Hello" --stdout-match "Hello" 0 __echo printf "%s" "Hello" || return $?
}
