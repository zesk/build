#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Test-Housekeeper-Overhead: true
testBashCommentFilter() {
  assertExitCode --stdout-no-match "SSH ""tests" --stdout-match "${FUNCNAME[0]}" 0 bashCommentFilter <"${BASH_SOURCE[0]}" || return $?
}

# Requires: A B C
# Requires: D E F G A a b c d
# Test-Housekeeper-Overhead: true
testBashGetRequires() {
  local handler="returnMessage"
  local temp

  temp=$(fileTemporaryName "$handler") || return $?
  __catch "$handler" bashGetRequires "${BASH_SOURCE[0]}" >"$temp" || return $?
  assertFileContains "$temp" A B C D E F G a b c d || return $?
  __catch "$handler" rm -f "$temp" || return $?
}

testBashBuiltins() {
  local item type
  while read -r item; do
    type=$(type -t "$item")
    assertExitCode --display "Type of $item" 0 inArray "$type" "builtin" "keyword" || return $?
  done < <(bashBuiltins)
}

# Requires: a b d
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
  local handler="returnMessage"
  local testPath clean=()

  testPath=$(fileTemporaryName "$handler" -d) || return $?
  clean+=("$testPath")

  assertNotExitCode --stderr-match "Requires a directory" 0 bashSourcePath || return $?
  assertNotExitCode --stderr-match "not directory" 0 bashSourcePath "$testPath/does-not-exist-i-hope" || return $?

  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/2.sh" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/1.sh" >"$testPath/2.sh"
  # Regardless of order someone will not exist

  assertNotExitCode --stderr-match "not executable" 0 bashSourcePath "$testPath" || return $?
  __catchEnvironment "$handler" muzzle makeShellFilesExecutable "$testPath" || return $?
  assertNotExitCode --stderr-match "not a bash source" 0 bashSourcePath "$testPath" || return $?

  __catchEnvironment "$handler" rm -rf "$testPath/"*.sh || return $?

  assertEquals "${ZESK_BUILD-}" "" || return $?
  printf "%s\n" "#!/usr/bin/env bash" "export ZESK_BUILD=true" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "_testZeskBuildFunction() {" "    decorate green Not easy being green." "}" >"$testPath/2.sh"
  __catchEnvironment "$handler" muzzle makeShellFilesExecutable "$testPath" || return $?

  assertExitCode --leak ZESK_BUILD 0 bashSourcePath "$testPath" || return $?

  assertEquals "${ZESK_BUILD-}" "true" || return $?
  assertExitCode 0 isFunction _testZeskBuildFunction || return $?

  __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  unset ZESK_BUILD
}

testBashSourcePathExclude() {
  local handler="returnMessage"
  local testPath

  testPath=$(fileTemporaryName "$handler" -d) || return $?

  __catchEnvironment "$handler" printf "%s\n" "#!/usr/bin/env bash" "echo \"\${BASH_SOURCE[0]}\";" >"$testPath/one.sh" || return $?
  __catchEnvironment "$handler" chmod +x "$testPath/one.sh" || return $?
  __catchEnvironment "$handler" cp "$testPath/one.sh" "$testPath/two.sh" || return $?
  __catchEnvironment "$handler" cp "$testPath/one.sh" "$testPath/__ignore.sh" || return $?

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

  __catchEnvironment "$handler" rm -rf "$testPath" || return $?
}

testBashSourcePathDot() {
  local handler="returnMessage"
  local testPath testPasses=false
  local clean=()

  testPath=$(fileTemporaryName "$handler" -d) || return $?

  clean+=("$testPath")

  __catchEnvironment "$handler" mkdir -p "$testPath/.foobar/.eefo/.dots" || return $?
  printf "%s\n" "testPasses=dots" >"$testPath/.foobar/.eefo/.dots/test.sh" || return $?
  printf "%s\n" "testPasses=eefo" >"$testPath/.foobar/.eefo/goo.sh" || return $?
  printf "%s\n" "testPasses=foobar" >"$testPath/.foobar/beep.sh" || return $?

  # Nothing works until chmod +x
  assertNotExitCode --stderr-match 'not executable' 0 bashSourcePath "$testPath/.foobar/.eefo/.dots/" || return $?
  assertNotExitCode --stderr-match 'not executable' 0 bashSourcePath "$testPath/.foobar/.eefo/" || return $?
  assertNotExitCode --stderr-match 'not executable' 0 bashSourcePath "$testPath/.foobar" || return $?
  assertExitCode --stdout-match test.sh --stdout-match goo.sh --stdout-match beep.sh 0 makeShellFilesExecutable "$testPath/.foobar/.eefo/.dots/" "$testPath/.foobar/.eefo/" "$testPath/.foobar/" || return $?

  assertExitCode --leak testPasses 0 bashSourcePath "$testPath/.foobar/.eefo/.dots/" || return $?
  assertEquals "$testPasses" "dots" || return $?

  testPasses=false

  assertExitCode --leak testPasses 0 bashSourcePath "$testPath/.foobar/.eefo/" || return $?
  assertEquals "$testPasses" "eefo" || return $?

  testPasses=false

  assertExitCode --leak testPasses 0 bashSourcePath "$testPath/.foobar" || return $?
  assertEquals "$testPasses" "foobar" || return $?

  __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  # Behavior is correct - ignore .dot directories within the bashSourcePath but not above it
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
  local handler="returnMessage"
  local temp

  export TEST_PIPE_RAN PIPE_RAN_FILE

  temp=$(fileTemporaryName "$handler") || return $?

  PIPE_RAN_FILE="$temp.ran"

  printf -- "" >"$PIPE_RAN_FILE"

  set -o pipefail
  local exitCode=0
  _testFunc | _pipeRan "$temp" || exitCode=$?
  echo "set -o pipefail - exit $exitCode"

  assertNotEquals --display "pipe fail causes both to fail" 0 "$exitCode" || return $?
  assertFileContains "$temp" hello || return $?
  assertFileContains "$PIPE_RAN_FILE" yes || return $?

  printf -- "" >"$PIPE_RAN_FILE"
  assertFileDoesNotContain "$PIPE_RAN_FILE" yes || return $?

  set +o pipefail
  exitCode=0
  _testFunc | _pipeRan "$temp" || exitCode=$?
  echo "set +o pipefail - exit $exitCode"

  assertEquals --display "pipe fail does not matter" 0 "$exitCode" || return $?
  assertFileContains "$temp" hello || return $?
  assertFileContains "$PIPE_RAN_FILE" yes || return $?
  rm -rf "$temp" "$PIPE_RAN_FILE"

  unset TEST_PIPE_RAN PIPE_RAN_FILE

}
