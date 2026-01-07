#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testIsType() {
  local types=()
  local var0="" var1=()
  export var2="" var3=()

  : "$var0" "${#var1[@]}"
  IFS=$'\n' read -r -d '' -a types < <(isType var0)
  assertExitCode 0 inArray "string" "${types[@]}" || return $?
  assertExitCode 0 inArray "local" "${types[@]}" || return $?
  IFS=$'\n' read -r -d '' -a types < <(isType var1)
  assertExitCode 0 inArray "array" "${types[@]}" || return $?
  assertExitCode 0 inArray "local" "${types[@]}" || return $?
  IFS=$'\n' read -r -d '' -a types < <(isType var2)
  assertExitCode 0 inArray "string" "${types[@]}" || return $?
  assertExitCode 0 inArray "export" "${types[@]}" || return $?
  IFS=$'\n' read -r -d '' -a types < <(isType var3)
  assertExitCode 0 inArray "array" "${types[@]}" || return $?
  assertExitCode 0 inArray "export" "${types[@]}" || return $?
  IFS=$'\n' read -r -d '' -a types < <(isType testIsType)
  assertExitCode 0 inArray "function" "${types[@]}" || return $?

  unset var2 var3
}
testIsBashBuiltin() {
  assertExitCode --stderr-match "Need builtin" 2 isBashBuiltin || return $?
  assertExitCode 0 isBashBuiltin --help || return $?
  assertExitCode 0 isBashBuiltin . || return $?
  assertExitCode 0 isBashBuiltin '[' || return $?
  assertExitCode 0 isBashBuiltin 'local' || return $?
  assertExitCode 1 isBashBuiltin 'awk' || return $?
}

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
  catchReturn "$handler" bashGetRequires "${BASH_SOURCE[0]}" >"$temp" || return $?
  assertFileContains "$temp" A B C D E F G a b c d || return $?
  catchReturn "$handler" rm -f "$temp" || return $?
}

# Tag: slow slow-non-critical
# Not really necessary but kind of neat to know
testBashBuiltins() {
  local item type
  while read -r item; do
    type=$(type -t "$item")
    assertExitCode --display "Type of $item is $type" 0 inArray "$type" "builtin" "keyword" || return $?
  done < <(bashBuiltins)
}

# Requires: a b d
# Tag: slow-non-critical
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

__doSetAndExit() {
  set "$@"
}

# Tag: slow-non-critical
testBashSetScopes() {
  local handler="returnMessage"

  local funScope=(e E u)
  local temp

  temp=$(fileTemporaryName "$handler") || return $?

  local opt
  for opt in a b e f m p k u C E T; do
    # Protects against `noclobber`
    catchEnvironment "$handler" rm -f "$temp" "$temp.1" "$temp.after" || return $?
    catchReturn "$handler" set -o >"$temp" || return $?
    set -o >"$temp.1"
    decorate success "Testing -$opt"
    __doSetAndExit "-$opt"
    set -o >"$temp.after"
    __doSetAndExit "+$opt"
    assertExitCode 0 muzzle diff -q "$temp" "$temp.1" || return $?
    if inArray "$opt" "${funScope[@]}"; then
      assertExitCode --display "$opt usually is scoped to a function so no changes should appear" 0 diff "$temp" "$temp.after" || return $?
    else
      assertNotExitCode --dump --display "$opt NOT scoped to a function so changes should be visible" 0 diff "$temp" "$temp.after" || return $?
    fi
  done
  catchEnvironment "$handler" rm -f "$temp" "$temp.1" "$temp.after" || return $?
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
  catchEnvironment "$handler" muzzle makeShellFilesExecutable "$testPath" || return $?
  assertNotExitCode --stderr-match "not a bash source" 0 bashSourcePath "$testPath" || return $?

  catchEnvironment "$handler" rm -rf "$testPath/"*.sh || return $?

  assertEquals "${ZESK_BUILD-}" "" || return $?
  printf "%s\n" "#!/usr/bin/env bash" "export ZESK_BUILD=true" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "_testZeskBuildFunction() {" "    decorate green Not easy being green." "}" >"$testPath/2.sh"
  catchEnvironment "$handler" muzzle makeShellFilesExecutable "$testPath" || return $?

  assertExitCode --leak ZESK_BUILD 0 bashSourcePath "$testPath" || return $?

  assertEquals "${ZESK_BUILD-}" "true" || return $?
  assertExitCode 0 isFunction _testZeskBuildFunction || return $?

  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  unset ZESK_BUILD
}

testBashSourcePathExclude() {
  local handler="returnMessage"
  local testPath

  testPath=$(fileTemporaryName "$handler" -d) || return $?

  catchEnvironment "$handler" printf "%s\n" "#!/usr/bin/env bash" "echo \"\${BASH_SOURCE[0]}\";" >"$testPath/one.sh" || return $?
  catchEnvironment "$handler" chmod +x "$testPath/one.sh" || return $?
  catchEnvironment "$handler" cp "$testPath/one.sh" "$testPath/two.sh" || return $?
  catchEnvironment "$handler" cp "$testPath/one.sh" "$testPath/__ignore.sh" || return $?

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

  catchEnvironment "$handler" rm -rf "$testPath" || return $?
}

testBashSourcePathDot() {
  local handler="returnMessage"
  local testPath testPasses=false
  local clean=()

  testPath=$(fileTemporaryName "$handler" -d) || return $?

  clean+=("$testPath")

  catchEnvironment "$handler" mkdir -p "$testPath/.foobar/.eefo/.dots" || return $?
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

  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
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
