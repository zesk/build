#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: assert.sh usage.sh
#

testUsageFunctions() {
  local match

  match=$(randomString)
  assertExitCode --line "$LINENO" --stderr-match "$match" 1 _environment "$match" || return $?
  assertExitCode --line "$LINENO" --stderr-match "$match" 2 _argument "$match" || return $?
  assertExitCode --line "$LINENO" --stderr-match "$match" 1 __failEnvironment _return "$match" || return $?
  assertExitCode --line "$LINENO" --stderr-match "$match" 2 __failArgument _return "$match" || return $?
  assertExitCode --line "$LINENO" --stderr-match "$match" 1 __usageEnvironment _return _return 99 "$match" || return $?
  assertExitCode --line "$LINENO" --stderr-match "$match" 2 __usageArgument _return _return 99 "$match" || return $?
}

__sampleArgs() {
  cat <<EOF
  --name value is required
  --value name
EOF
}

testUsageArguments1() {
  local results

  results=$(__environment mktemp) || return $?
  __sampleArgs | usageArguments " " "" "" >"$results"

  assertEquals " --name [ --value ]" "$(cat "$results")" || return $?

  __environment rm "$results" || return $?
}

__testUsageArgumentsFile() {
  cat <<'EOF'
     --test^Optional thing.
     variable^OptionalTHing
     third^Required thing
EOF
}
testUsageArguments() {
  local value testIndex=0

  IFS= read -r -d '' value < <(__testUsageArgumentsFile)

  printf "VALUE=%s\n=====\n" "$value"

  printf "ARGS: %s\n=====\n" "$(printf %s "$value" | usageArguments "^")"
  assertContains --display "test # $testIndex" "test" "$(printf "%s" "$value" | usageArguments "^")" || return $?
  testIndex=$((testIndex + 1))
  assertContains "variable" "$(printf "%s" "$value" | usageArguments "^")" || return $?
  testIndex=$((testIndex + 1))

  value="$(printf "%s\n%s\n" "--test^Optional thing." "variable^Another optional thing. newline at end")"
  printf "ARGS: %s\n=====\n" "$(printf %s "$value" | usageArguments "^")"
  assertContains --display "test # $testIndex" "test" "$(printf "%s" "$value" | usageArguments "^")" || return $?
  testIndex=$((testIndex + 1))
  assertContains "variable" "$(printf "%s" "$value" | usageArguments "^")" || return $?
  testIndex=$((testIndex + 1))

  value="$(printf "%s\n%s" "--test^Optional thing." "variable^Another optional thing.")"
  printf "ARGS: %s\n=====\n" "$(printf %s "$value" | usageArguments "^")"
  assertContains --display "test # $testIndex" "test" "$(printf "%s" "$value" | usageArguments "^")" || return $?
  testIndex=$((testIndex + 1))
  assertContains "variable" "$(printf "%s" "$value" | usageArguments "^")" || return $?
  testIndex=$((testIndex + 1))
}

_testUsageArgumentHelperSuccess() {
  local usageFunction

  usageFunction="$1"
  shift || :

  while [ $# -gt 0 ]; do
    printf "%s" "" >"$TEST_USAGE"
    assertExitCode 0 "$usageFunction" _usageWasCalled "testName ->" "$1" || return $?
    assertEquals "" "$(cat "$TEST_USAGE")" || return $?
    shift || :
  done
}

_testUsageArgumentHelperFail() {
  local usageFunction

  export TEST_USAGE
  usageFunction="$1"
  shift || :

  while [ $# -gt 0 ]; do
    printf "%s" "" >"$TEST_USAGE"
    assertNotExitCode 0 "$usageFunction" _usageWasCalled "testName ->" "$1" || _environment "$usageFunction $(decorate warning "fail $1")" || return $?
    assertEquals "yes" "$(cat "$TEST_USAGE")" || _environment "$usageFunction did not write $(decorate code "$TEST_USAGE")" || return $?
    shift || :
  done
}

testUsageArgumentFunctions() {
  local d intTests unsignedIntTests positiveIntTests

  d=$(mktemp -d) || return $?

  export TEST_USAGE="$d/artifact"

  _testUsageArgumentHelperSuccess usageArgumentFileDirectory "$d" "$(pwd)" "/" "$d/inside" "NOT-a-dir-but-works-as-it-resolves-to-dot" "../../../../../ha-ends-at-root" || return $?

  _testUsageArgumentHelperSuccess usageArgumentDirectory "$d" "$(pwd)" "/" || return $?

  _testUsageArgumentHelperFail usageArgumentDirectory "$d/foo" "NOT-a-dir" "../../../../../ha" || return $?

  _testUsageArgumentHelperFail usageArgumentFileDirectory "$d/foo/bar" || return $?

  unsignedIntTests=(99 1 0 4123123412412 492 8192)
  intTests=(-42 -99 -5912381239102398123 -0 -1)
  positiveIntTests=(99 1 4123123412412 492 8192)

  _testUsageArgumentHelperSuccess usageArgumentInteger "${intTests[@]}" "${unsignedIntTests[@]}" || return $?

  _testUsageArgumentHelperFail usageArgumentInteger -1e1 1.0 1d2 jq || return $?

  _testUsageArgumentHelperSuccess usageArgumentUnsignedInteger "${unsignedIntTests[@]}" || return $?

  _testUsageArgumentHelperFail usageArgumentUnsignedInteger "${intTests[@]}" -1.0 1.0 1d2 jq '9123-' what || return $?

  _testUsageArgumentHelperSuccess usageArgumentPositiveInteger "${positiveIntTests[@]}" || return $?

  _testUsageArgumentHelperFail usageArgumentPositiveInteger "${intTests[@]}" -1.0 1.0 1d2 jq '9123-' what 0 || return $?

  unset TEST_USAGE
}

_usageWasCalled() {
  decorate error "_usageWasCalled ${FUNCNAME[0]} $*"
  export TEST_USAGE
  printf "%s" "yes" >"$TEST_USAGE"
  return "$1"
}
