#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBashBasics() {
  # Bizarre logic precedence

  # first section
  assertEquals --line "$LINENO" hitTheOr "$(false && true || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(true && false || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(false && false || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" "" "$(true && true || printf hitTheOr)" || return $?

  # Added && to end of first section
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(false && true || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(true && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(false && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" "hitTheAnd" "$(true && true || printf hitTheOr && printf hitTheAnd)" || return $?

  # Added || to end of first section
  assertEquals --line "$LINENO" hitTheOr "$(false && true || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(true && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(false && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" "" "$(true && true || printf hitTheOr || printf hitTheAnd)" || return $?
}

testBashSourcePath() {
  local testPath

  testPath=$(__environment mktemp -d) || return $?

  assertNotExitCode --line "$LINENO" --stderr-match "Requires a directory" 0 bashSourcePath || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "not directory" 0 bashSourcePath "$testPath/does-not-exist-i-hope" || return $?

  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/2.sh" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/1.sh" >"$testPath/2.sh"
  # Regardless of order someone will not exist

  assertNotExitCode --line "$LINENO" --stderr-match "not executable" 0 bashSourcePath "$testPath" || return $?
  __environment muzzle makeShellFilesExecutable "$testPath" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "not a bash source" 0 bashSourcePath "$testPath" || return $?

  __environment rm -rf "$testPath/"*.sh || return $?

  assertEquals "${ZESK_BUILD-}" "" || return $?
  printf "%s\n" "#!/usr/bin/env bash" "export ZESK_BUILD=true" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "_testZeskBuildFunction() {" "    decorate green Not easy being green." "}" >"$testPath/2.sh"
  __environment muzzle makeShellFilesExecutable "$testPath" || return $?

  assertExitCode --leak ZESK_BUILD --line "$LINENO" 0 bashSourcePath "$testPath" || return $?

  assertEquals --line "$LINENO" "${ZESK_BUILD-}" "true" || return $?
  assertExitCode --line "$LINENO" 0 isFunction _testZeskBuildFunction || return $?

  unset ZESK_BUILD
}

testBashSourcePathDot() {
  local testPath testPasses=false

  testPath=$(__environment mktemp -d) || return $?

  __environment mkdir -p "$testPath/.foobar/.eefo/.dots" || return $?
  printf "%s\n" "testPasses=dots" >"$testPath/.foobar/.eefo/.dots/test.sh" || return $?
  printf "%s\n" "testPasses=eefo" >"$testPath/.foobar/.eefo/goo.sh" || return $?
  printf "%s\n" "testPasses=foobar" >"$testPath/.foobar/beep.sh" || return $?

  # Nothing works until chmod +x
  assertNotExitCode --stderr-match 'not executable' --line "$LINENO" 0 bashSourcePath "$testPath/.foobar/.eefo/.dots/" || return $?
  assertNotExitCode --stderr-match 'not executable' --line "$LINENO" 0 bashSourcePath "$testPath/.foobar/.eefo/" || return $?
  assertNotExitCode --stderr-match 'not executable' --line "$LINENO" 0 bashSourcePath "$testPath/.foobar" || return $?
  assertExitCode --stdout-match test.sh --stdout-match goo.sh --stdout-match beep.sh 0 makeShellFilesExecutable "$testPath/.foobar/.eefo/.dots/" "$testPath/.foobar/.eefo/" "$testPath/.foobar/" || return $?

  assertExitCode --leak testPasses --line "$LINENO" 0 bashSourcePath "$testPath/.foobar/.eefo/.dots/" || return $?
  assertEquals --line "$LINENO" "$testPasses" "dots" || return $?

  testPasses=false

  assertExitCode --leak testPasses --line "$LINENO" 0 bashSourcePath "$testPath/.foobar/.eefo/" || return $?
  assertEquals --line "$LINENO" "$testPasses" "eefo" || return $?

  testPasses=false

  assertExitCode --leak testPasses --line "$LINENO" 0 bashSourcePath "$testPath/.foobar" || return $?
  assertEquals --line "$LINENO" "$testPasses" "foobar" || return $?

  # Behavior is correct - ignore .dot directories within the bashSourcePath but not above it
}

testBashSourceInteractive() {
  export BUILD_PROMPT_MOCK=yes

}
