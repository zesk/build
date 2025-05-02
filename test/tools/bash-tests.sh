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
  assertEquals hitTheOr "$(false && true || printf hitTheOr)" || return $?
  assertEquals hitTheOr "$(true && false || printf hitTheOr)" || return $?
  assertEquals hitTheOr "$(false && false || printf hitTheOr)" || return $?
  assertEquals "" "$(true && true || printf hitTheOr)" || return $?

  # Added && to end of first section
  assertEquals hitTheOrhitTheAnd "$(false && true || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals hitTheOrhitTheAnd "$(true && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals hitTheOrhitTheAnd "$(false && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals "hitTheAnd" "$(true && true || printf hitTheOr && printf hitTheAnd)" || return $?

  # Added || to end of first section
  assertEquals hitTheOr "$(false && true || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals hitTheOr "$(true && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals hitTheOr "$(false && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals "" "$(true && true || printf hitTheOr || printf hitTheAnd)" || return $?
}

testBashSourcePath() {
  local testPath

  testPath=$(__environment mktemp -d) || return $?

  assertNotExitCode --stderr-match "Requires a directory" 0 bashSourcePath || return $?
  assertNotExitCode --stderr-match "not directory" 0 bashSourcePath "$testPath/does-not-exist-i-hope" || return $?

  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/2.sh" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/1.sh" >"$testPath/2.sh"
  # Regardless of order someone will not exist

  assertNotExitCode --stderr-match "not executable" 0 bashSourcePath "$testPath" || return $?
  __environment muzzle makeShellFilesExecutable "$testPath" || return $?
  assertNotExitCode --stderr-match "not a bash source" 0 bashSourcePath "$testPath" || return $?

  __environment rm -rf "$testPath/"*.sh || return $?

  assertEquals "${ZESK_BUILD-}" "" || return $?
  printf "%s\n" "#!/usr/bin/env bash" "export ZESK_BUILD=true" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "_testZeskBuildFunction() {" "    decorate green Not easy being green." "}" >"$testPath/2.sh"
  __environment muzzle makeShellFilesExecutable "$testPath" || return $?

  assertExitCode --leak ZESK_BUILD 0 bashSourcePath "$testPath" || return $?

  assertEquals "${ZESK_BUILD-}" "true" || return $?
  assertExitCode 0 isFunction _testZeskBuildFunction || return $?

  unset ZESK_BUILD
}

testBashSourcePathExclude() {
  local usage="_return"
  local testPath

  testPath=$(fileTemporaryName "$usage" -d) || return $?

  __catchEnvironment "$usage" printf "%s\n" "#!/usr/bin/env bash" "echo \"\${BASH_SOURCE[0]}\";" >"$testPath/one.sh" || return $?
  __catchEnvironment "$usage" chmod +x "$testPath/one.sh" || return $?
  __catchEnvironment "$usage" cp "$testPath/one.sh" "$testPath/two.sh" || return $?
  __catchEnvironment "$usage" cp "$testPath/one.sh" "$testPath/__ignore.sh" || return $?

  local matches=(
    --stdout-match "__ignore.sh"
    --stdout-match "one.sh"
    --stdout-match "two.sh"
  )

  assertExitCode "${matches[@]}" 0 bashSourcePath "$testPath/" || return $?
  matches=(
    --stdout-no-match "__ignore.sh"
    --stdout-match "one.sh"
    --stdout-match "two.sh"
  )
  assertExitCode "${matches[@]}" 0 bashSourcePath --exclude "*/__ignore.sh" "$testPath/" || return $?
  matches=(
    --stdout-no-match "__ignore.sh"
    --stdout-no-match "one.sh"
    --stdout-match "two.sh"
  )
  assertExitCode "${matches[@]}" 0 bashSourcePath --exclude "*/__ignore.sh" --exclude "*/one*" "$testPath/" || return $?
  matches=(
    --stdout-no-match "__ignore.sh"
    --stdout-no-match "one.sh"
    --stdout-no-match "two.sh"
  )
  assertExitCode "${matches[@]}" 0 bashSourcePath --exclude "*/__ignore.sh" --exclude "*/*" "$testPath/" || return $?

  __catchEnvironment "$usage" rm -rf "$testPath" || return $?
}

testBashSourcePathDot() {
  local testPath testPasses=false

  testPath=$(__environment mktemp -d) || return $?

  __environment mkdir -p "$testPath/.foobar/.eefo/.dots" || return $?
  printf "%s\n" "testPasses=dots" >"$testPath/.foobar/.eefo/.dots/test.sh" || return $?
  printf "%s\n" "testPasses=eefo" >"$testPath/.foobar/.eefo/goo.sh" || return $?
  printf "%s\n" "testPasses=foobar" >"$testPath/.foobar/beep.sh" || return $?

  # Nothing works until chmod +x
  assertNotExitCode --stderr-match 'not executable' 0 bashSourcePath "$testPath/.foobar/.eefo/.dots/" || return $?
  assertNotExitCode --stderr-match 'not executable' 0 bashSourcePath "$testPath/.foobar/.eefo/" || return $?
  assertNotExitCode --stderr-match 'not executable' --line "$LINENO" 0 bashSourcePath "$testPath/.foobar" || return $?
  assertExitCode --stdout-match test.sh --stdout-match goo.sh --stdout-match beep.sh 0 makeShellFilesExecutable "$testPath/.foobar/.eefo/.dots/" "$testPath/.foobar/.eefo/" "$testPath/.foobar/" || return $?

  assertExitCode --leak testPasses --line "$LINENO" 0 bashSourcePath "$testPath/.foobar/.eefo/.dots/" || return $?
  assertEquals "$testPasses" "dots" || return $?

  testPasses=false

  assertExitCode --leak testPasses --line "$LINENO" 0 bashSourcePath "$testPath/.foobar/.eefo/" || return $?
  assertEquals "$testPasses" "eefo" || return $?

  testPasses=false

  assertExitCode --leak testPasses --line "$LINENO" 0 bashSourcePath "$testPath/.foobar" || return $?
  assertEquals "$testPasses" "foobar" || return $?

  # Behavior is correct - ignore .dot directories within the bashSourcePath but not above it
}

testBashSourceInteractive() {
  export BUILD_PROMPT_MOCK=yes

}

_testFunc() {
  echo hello
  return 1
}
_pipeRan() {
  export PIPE_RAN_FILE
  echo "yes" >"$PIPE_RAN_FILE"
  tee "$@"
}
testBashPipeBehavior() {
  local temp

  export TEST_PIPE_RAN PIPE_RAN_FILE

  temp=$(mktemp) || return $?

  PIPE_RAN_FILE="$temp.ran"

  printf -- "" >"$PIPE_RAN_FILE"

  set -o pipefail
  exitCode=0
  _testFunc | _pipeRan "$temp" || exitCode=$?
  echo "set -o pipefail - exit $exitCode"

  assertNotEquals --line "$LINENO" --display "pipe fail causes both to fail" 0 "$exitCode" || return $?
  assertFileContains --line "$LINENO" "$temp" hello || return $?
  assertFileContains --line "$LINENO" "$PIPE_RAN_FILE" yes || return $?

  printf -- "" >"$PIPE_RAN_FILE"
  assertFileDoesNotContain --line "$LINENO" "$PIPE_RAN_FILE" yes || return $?

  set +o pipefail
  exitCode=0
  _testFunc | _pipeRan "$temp" || exitCode=$?
  echo "set +o pipefail - exit $exitCode"

  assertEquals --display "pipe fail does not matter" 0 "$exitCode" || return $?
  assertFileContains --line "$LINENO" "$temp" hello || return $?
  assertFileContains --line "$LINENO" "$PIPE_RAN_FILE" yes || return $?
  rm -rf "$temp" "$PIPE_RAN_FILE"

  unset TEST_PIPE_RAN PIPE_RAN_FILE

}
