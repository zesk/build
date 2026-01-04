#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

_usageArgumentTypeList() {
  local prefix="usageArgument"
  declare -F | removeFields 2 | grepSafe -e "^$prefix" | cut -c "$((${#prefix} + 1))"- | sort
}

testValidateMissing() {
  local handler="returnMessage"
  local usageTypes validateTypes

  usageTypes=$(fileTemporaryName "$handler") || return $?
  validateTypes=$(fileTemporaryName "$handler") || return $?

  catchEnvironment "$handler" _usageArgumentTypeList >"$usageTypes" || return $?
  catchEnvironment "$handler" validateTypeList >"$validateTypes" || return $?

  printf "%s %s\n" "$(decorate red "< usage")" "$(decorate green "> validate")"
  diff --suppress-common-lines "$usageTypes" "$validateTypes" | grepSafe -e '^[<>]' || :

  catchEnvironment "$handler" rm -rf "$usageTypes" "$validateTypes" || return $?
}

_testValidateArgumentHelperSuccess() {
  local validateType

  validateType="$1"
  shift

  while [ $# -gt 0 ]; do
    printf "%s" "" >"$_TEST_VALIDATE_HANDLER"
    assertExitCode 0 validate _validateHandlerWasCalled "$validateType" "testName ->" "$1" || return $?
    assertEquals "" "$(cat "$_TEST_VALIDATE_HANDLER")" || return $?
    shift
  done
}

_testValidateArgumentHelperFail() {
  local validateType

  export _TEST_VALIDATE_HANDLER
  validateType="$1"
  shift

  while [ $# -gt 0 ]; do
    printf "%s" "" >"$_TEST_VALIDATE_HANDLER"
    assertNotExitCode 0 validate _validateHandlerWasCalled "$validateType" "testName ->" "$1" || returnEnvironment "$validateType $(decorate warning "fail $1")" || return $?
    assertEquals "yes" "$(cat "$_TEST_VALIDATE_HANDLER")" || returnEnvironment "$validateType did not write $(decorate code "$_TEST_VALIDATE_HANDLER")" || return $?
    shift
  done
}

# Tag: slow
testValidateFunctions() {
  local handler="returnMessage"

  local d intTests unsignedIntTests positiveIntTests

  d=$(fileTemporaryName "$handler" -d) || return $?

  export _TEST_VALIDATE_HANDLER="$d/artifact"

  _testValidateArgumentHelperSuccess FileDirectory "$d" "$(pwd)" "/" "$d/inside" "NOT-a-dir-but-works-as-it-resolves-to-dot" "../../../../../ha-ends-at-root" || return $?

  _testValidateArgumentHelperSuccess Directory "$d" "$(pwd)" "/" || return $?

  _testValidateArgumentHelperFail Directory "$d/foo" "NOT-a-dir" "../../../../../ha" || return $?

  _testValidateArgumentHelperFail FileDirectory "$d/foo/bar" || return $?

  unsignedIntTests=(99 1 0 4123123412412 492 8192)
  intTests=(-42 -99 -5912381239102398123 -0 -1)
  positiveIntTests=(99 1 4123123412412 492 8192)

  _testValidateArgumentHelperSuccess Integer "${intTests[@]}" "${unsignedIntTests[@]}" || return $?

  _testValidateArgumentHelperFail Integer -1e1 1.0 1d2 jq || return $?

  _testValidateArgumentHelperSuccess UnsignedInteger "${unsignedIntTests[@]}" || return $?

  _testValidateArgumentHelperFail UnsignedInteger "${intTests[@]}" -1.0 1.0 1d2 jq '9123-' what || return $?

  _testValidateArgumentHelperSuccess PositiveInteger "${positiveIntTests[@]}" || return $?

  _testValidateArgumentHelperFail PositiveInteger "${intTests[@]}" -1.0 1.0 1d2 jq '9123-' what 0 || return $?

  catchEnvironment "$handler" rm -f "$_TEST_VALIDATE_HANDLER" || return $?

  unset _TEST_VALIDATE_HANDLER
}

_validateHandlerWasCalled() {
  decorate error "_validateHandlerWasCalled ${FUNCNAME[0]} $*"
  export _TEST_VALIDATE_HANDLER
  printf "%s" "yes" >"$_TEST_VALIDATE_HANDLER"
  return "$1"
}
