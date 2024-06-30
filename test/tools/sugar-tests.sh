#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

_wasRun() {
  local exitCode

  export SUGAR_FILE
  exitCode=0
  if [ -f "$SUGAR_FILE" ]; then
    if [ ! -s "$SUGAR_FILE" ]; then
      # Zero sized
      exitCode=98
    else
      # Non-zero sized
      exitCode=99
    fi

  fi
  date >>"$SUGAR_FILE"
  return "$exitCode"
}

tests+=(testSugar)
testSugar() {
  local code

  # __return running stuff
  export SUGAR_FILE
  SUGAR_FILE=$(mktemp) || _environment mktemp || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=98
  assertExitCode --dump --stderr-match "$code" "$code" __return _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --dump --stderr-match "$code" "$code" __return _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  assertEquals $(($(wc -l <"$SUGAR_FILE") + 0)) 2 || return $?
  __environment rm -rf "$SUGAR_FILE" || return $?
  assertFileDoesNotExist "$SUGAR_FILE" || return $?
  code=0
  assertExitCode 0 __return _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --dump --stderr-match "$code" "$code" __return _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --dump --stderr-match "$code" "$code" __return _wasRun || return $?
  assertEquals $(($(wc -l <"$SUGAR_FILE") + 0)) 3 || return $?
  rm -rf "$SUGAR_FILE"
  unset SUGAR_FILE

  # set -x

  assertEquals "$(printf "Hello\n- a\n- b\n- c\n- d e\n")" "$(_list "Hello" "a" "b" "c" "d e")" || return $?

  # _exit
  assertEquals "99" "$( (_exit) || echo $?)" || return $?

  # _return
  for code in $(seq 0 127); do
    assertExitCode --stderr-ok "$code" _return "$code" || return $?
  done
  # __return
  for code in $(seq 0 127); do
    assertExitCode --stderr-ok "$code" __return _return "$code" || return $?
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

  # set +x
}
