#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

tests+=(testMoreSugar)
tests+=(testExitCode)
tests+=(testSugar)

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

testExitCode() {
  local code char digit

  assertEquals --line "$LINENO" 1 "$(_code environment)" || return $?
  assertEquals --line "$LINENO" 2 "$(_code argument)" || return $?
  assertEquals --line "$LINENO" "" "$(_code)" || return $?
  assertEquals --line "$LINENO" "97" "$(_code assert)" || return $?
  assertEquals --line "$LINENO" "$(printf "%d\n" 97 97)" "$(_code assert assert)" || return $?
  assertEquals --line "$LINENO" "105" "$(_code identical)" || return $?
  assertEquals --line "$LINENO" "108" "$(_code leak)" || return $?
  assertEquals --line "$LINENO" "116" "$(_code test)" || return $?
  assertEquals --line "$LINENO" "253" "$(_code internal)" || return $?
  assertEquals --line "$LINENO" "254" "$(_code adsfa01324kjadksfj)" || return $?
  assertEquals --line "$LINENO" "254" "$(_code adsfa01324kjadksfj1)" || return $?

  assertOutputContains --exit "$(_code internal)" --stderr non-integer _return notInt "message for return"

  for code in assert identical leak "test"; do
    char="${code:0:1}"
    digit=$(_code "$code")
    assertEquals --line "$LINENO" "$digit" "$(characterToInteger "$char")" characterToInteger "$char" || return $?
    assertEquals --line "$LINENO" "$char" "$(characterFromInteger "$digit")" characterFromInteger "$digit" || return $?
  done
}

testSugar() {
  local code

  # __return running stuff
  export SUGAR_FILE
  SUGAR_FILE=$(mktemp) || _environment mktemp || return $?
  assertFileExists --line "$LINENO" "$SUGAR_FILE" || return $?
  code=98
  assertExitCode --line "$LINENO" --stderr-match "$code" "$code" __return _wasRun || return $?
  assertFileExists --line "$LINENO" "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --line "$LINENO" --stderr-match "$code" "$code" __return _wasRun || return $?
  assertFileExists --line "$LINENO" "$SUGAR_FILE" || return $?
  assertEquals --line "$LINENO" $(($(wc -l <"$SUGAR_FILE") + 0)) 2 || return $?
  __environment rm -rf "$SUGAR_FILE" || return $?
  assertFileDoesNotExist --line "$LINENO" "$SUGAR_FILE" || return $?
  code=0
  assertExitCode --line "$LINENO" 0 __return _wasRun || return $?
  assertFileExists --line "$LINENO" "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --line "$LINENO" --stderr-match "$code" "$code" __return _wasRun || return $?
  assertFileExists --line "$LINENO" "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --line "$LINENO" --stderr-match "$code" "$code" __return _wasRun || return $?
  assertEquals --line "$LINENO" $(($(wc -l <"$SUGAR_FILE") + 0)) 3 || return $?
  rm -rf "$SUGAR_FILE"
  unset SUGAR_FILE

  assertEquals --line "$LINENO" "$(printf "Hello\n- a\n- b\n- c\n- d e\n")" "$(_list "Hello" "a" "b" "c" "d e")" || return $?

  # _exit
  assertEquals --line "$LINENO" "99" "$( (__try _return 99) || echo $?)" || return $?

  # _return
  for code in $(seq 0 127); do
    assertExitCode --line "$LINENO" --stderr-ok "$code" _return "$code" || return $?
  done
  # __return
  for code in $(seq 0 127); do
    assertExitCode --line "$LINENO" --stderr-ok "$code" __return _return "$code" || return $?
  done

  # _environment
  # _argument
  assertExitCode --line "$LINENO" --stderr-ok 1 _environment || return $?
  assertExitCode --line "$LINENO" --stderr-ok 2 _argument || return $?

  assertExitCode --line "$LINENO" --stderr-ok 1 _environment 1 2 3 || return $?
  assertExitCode --line "$LINENO" --stderr-ok 2 _argument a b c || return $?

  # __execute
  assertExitCode --line "$LINENO" --stderr-match foo 1 __execute _environment "foo" || return $?
  assertExitCode --line "$LINENO" --stderr-match foo 2 __execute _argument "foo" || return $?
  # __echo
  assertExitCode --line "$LINENO" --stdout-match " printf \"%s\" \"Hello\"" --stdout-match "Hello" 0 __echo printf "%s" "Hello" || return $?
}

testMoreSugar() {
  local mockUsage=__testMoreSugarUsage

  assertExitCode --line "$LINENO" --stderr-match whoops "$(_code environment)" __usageEnvironment "$mockUsage" _argument "whoops" || return $?
  assertExitCode --line "$LINENO" --stderr-match a-daisy "$(_code argument)" __usageArgument "$mockUsage" _environment "a-daisy" || return $?
}
__testMoreSugarUsage() {
  return "$1"
}
