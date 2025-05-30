#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

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

__alwaysFail() {
  return 1
}

testReturn() {
  assertExitCode --stderr-match "99" 99 _return 99 || return $?
  assertExitCode 0 _return 0 || return $?
}

testUndo() {
  assertExitCode 1 _undo 1 || return $?
  assertExitCode --stdout-match Hello --stdout-no-match world 1 _undo 1 printf "%s\n" "Hello" || return $?
  assertExitCode --stdout-match Hello --stdout-no-match world 1 _undo 1 printf "%s\n" "Hello" -- || return $?
  assertExitCode --stdout-match Hello --stdout-no-match world 1 _undo 1 printf "%s\n" "Hello" -- -- -- || return $?
  assertExitCode --stdout-match Hello --stdout-match world 1 _undo 1 printf "%s\n" "Hello" -- printf "%s\n" "world" || return $?
  assertExitCode --stdout-match Hello --stdout-match world 1 _undo 1 printf "%s\n" "Hello" -- printf "%s\n" "world" -- || return $?
}

testMapReturn() {
  assertExitCode 99 mapReturn 1 1 99 || return $?
  assertExitCode 99 mapReturn 1 1 99 1 98 || return $?
  assertExitCode 99 mapReturn 99 1 99 2 98 || return $?
  assertExitCode 98 mapReturn 2 1 99 2 98 || return $?
  local i
  for i in $(seq 1 10); do
    assertExitCode $((i + 1)) mapReturn "$i" 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 || return $?
  done
}

test__catchCode() {
  assertNotExitCode --stderr-match "Not a function" 0 __catchCode || return $?
  assertNotExitCode --stderr-match "Not integer" 0 __catchCode 12n || return $?
  assertNotExitCode --stderr-match "Not callable" 0 __catchCode 12 _return "not-callable-thing" || return $?
  assertExitCode 0 __catchCode 12 _return printf -- "" || return $?
  assertExitCode --stdout-match "Hello, world" 0 __catchCode 12 _return printf -- "Hello, world" || return $?
  assertExitCode --stderr-match "__alwaysFail" 12 __catchCode 12 _return __alwaysFail || return $?
}

testBoolean() {
  assertExitCode 0 isBoolean true || return $?
  assertExitCode 0 isBoolean false || return $?
  assertNotExitCode 0 isBoolean True || return $?
  assertNotExitCode 0 isBoolean False || return $?
  assertNotExitCode 0 isBoolean 0 || return $?
  assertNotExitCode 0 isBoolean 1 || return $?
  assertNotExitCode 0 isBoolean yes || return $?
  assertNotExitCode 0 isBoolean no || return $?
}

testChoose() {
  local errors here

  assertEquals "2" "$(_choose falseish A B 2>/dev/null || printf "%d" $?)"
  errors="$(_choose falseish A B 2>&1 || :)" || : && here="${BASH_SOURCE[0]}:$LINENO"
  assertExitCode 0 isSubstring "$here" "$errors" || return $?

  assertExitCode 0 _choose true || return $?
  assertExitCode 0 _choose false || return $?
  assertNotExitCode --stderr-match 'non-boolean' 0 _choose True || return $?
  assertNotExitCode --stderr-match 'non-boolean' 0 _choose False || return $?
  assertNotExitCode --stderr-match 'non-boolean' 0 _choose 0 || return $?
  assertNotExitCode --stderr-match 'non-boolean' 0 _choose 1 || return $?
  assertNotExitCode --stderr-match 'non-boolean' 0 _choose TRUE || return $?
  assertNotExitCode --stderr-match 'non-boolean' 0 _choose FALSE || return $?
  assertOutputEquals yes _choose true yes no || return $?
  assertOutputEquals --line "$LINENO" no _choose false yes no || return $?
  assertOutputEquals --line "$LINENO" B _choose false A B || return $?
}

testExitCode() {
  local code char digit

  assertEquals 1 "$(_code environment)" || return $?
  assertEquals 2 "$(_code argument)" || return $?
  assertEquals "" "$(_code)" || return $?
  assertEquals "97" "$(_code assert)" || return $?
  assertEquals "$(printf "%d\n" 97 97)" "$(_code assert assert)" || return $?
  assertEquals "105" "$(_code identical)" || return $?
  assertEquals "108" "$(_code leak)" || return $?
  assertEquals "116" "$(_code timeout)" || return $?
  assertEquals "253" "$(_code internal)" || return $?
  assertEquals "254" "$(_code adsfa01324kjadksfj)" || return $?
  assertEquals "254" "$(_code adsfa01324kjadksfj1)" || return $?

  assertExitCode --stderr-match non-integer --stderr-match "message for return" "$(_code argument)" _return notInt "message for return"

  for code in assert identical leak "timeout"; do
    char="${code:0:1}"
    digit=$(_code "$code")
    assertEquals "$digit" "$(characterToInteger "$char")" characterToInteger "$char" || return $?
    assertEquals "$char" "$(characterFromInteger "$digit")" characterFromInteger "$digit" || return $?
  done
}

testExitCodeCase() {
  local code char digit

  assertEquals "254" "$(_code EnViRoNmEnT)" || return $?
  assertEquals "254" "$(_code Internal)" || return $?
  assertEquals "254" "$(_code adsFa01324kjadksfj)" || return $?
  assertEquals "254" "$(_code adsfa01324kjadksfj1)" || return $?
}

testSugar() {
  local code

  # __execute running stuff
  export SUGAR_FILE
  SUGAR_FILE=$(mktemp) || _environment mktemp || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=98
  assertExitCode --stderr-match "$code" "$code" __execute _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --stderr-match "$code" "$code" __execute _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  assertEquals $(($(wc -l <"$SUGAR_FILE") + 0)) 2 || return $?
  __environment rm -rf "$SUGAR_FILE" || return $?
  assertFileDoesNotExist --line "$LINENO" "$SUGAR_FILE" || return $?
  code=0
  assertExitCode 0 __execute _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --stderr-match "$code" "$code" __execute _wasRun || return $?
  assertFileExists "$SUGAR_FILE" || return $?
  code=99
  assertExitCode --stderr-match "$code" "$code" __execute _wasRun || return $?
  assertEquals $(($(wc -l <"$SUGAR_FILE") + 0)) 3 || return $?
  rm -rf "$SUGAR_FILE"
  unset SUGAR_FILE

  # _return
  for code in 0 31 42 255; do
    assertExitCode --stderr-ok "$code" _return "$code" || return $?
  done
  # __execute
  for code in 0 29 101 255; do
    assertExitCode --stderr-ok "$code" __execute _return "$code" || return $?
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
  assertExitCode --stdout-match " \"printf\" \"%s\" \"Hello\"" --stdout-match "Hello" 0 __echo printf "%s" "Hello" || return $?
}

testMoreSugar() {
  local usageMock=__testMoreSugarUsage

  assertExitCode --stderr-match whoops "$(_code environment)" __catchEnvironment "$usageMock" _argument "whoops" || return $?
  assertExitCode --stderr-match a-daisy "$(_code argument)" __catchArgument "$usageMock" _environment "a-daisy" || return $?
}
__testMoreSugarUsage() {
  return "$1"
}

testArgEnvStuff() {
  local k usage="_return"

  k=$(_code environment)
  assertExitCode --stderr-match foo "$k" _environment "foo" || return $?
  assertExitCode --stderr-match foo "$k" __throwEnvironment _return "foo" || return $?
  assertExitCode --stderr-match foo "$k" __catchEnvironment "$usage" _return 99 foo || return $?

  k=$(_code argument)
  assertExitCode --stderr-match foo "$k" _argument "foo" || return $?
  assertExitCode --stderr-match foo "$k" __throwArgument _return "foo" || return $?
  assertExitCode --stderr-match foo "$k" __catchArgument "$usage" _return 99 foo || return $?
}

testMuzzle() {
  local home mantra="I'm sorry, Dave, I'm afraid I can't do that."

  home=$(__environment buildHome) || return $?

  # produces nothing
  assertOutputEquals "" muzzle cat "${BASH_SOURCE[0]}" || return $?
  assertOutputEquals "" muzzle echo "${FUNCNAME[0]}" || return $?
  assertOutputEquals "" muzzle decorate info "$mantra" || return $?
  # ls produces something
  assertOutputContains "bin" ls "$home" || return $?
  assertOutputContains "README.md" ls "$home" || return $?
  # ls produces nothing
  assertOutputEquals "" muzzle ls "$home" || return $?
  # Does not block stderr
  assertExitCode --stderr-match "Dave" 71 muzzle _return 71 "$mantra" || return $?
}
