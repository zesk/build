#!/usr/bin/env bash
#
# Tests for jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.

test_jUnitBasic() {
  local handler="returnMessage"

  local rando

  rando=$(catchReturn "$handler" stringRandom) || return $?

  assertOutputContains "<testsuites " junitOpen "name=Test run" || return $?
  assertOutputContains "</testsuites>" junitClose "name=Test run" || return $?
  assertOutputContains "</testsuite>" junitSuiteClose "name=Test run" || return $?
  assertOutputContains "<testsuite " junitSuiteOpen "name=$rando" || return $?
  local matches=(
    --stdout-match "<properties>"
    --stdout-match "<property name=\"name\" value=\"$rando\" />"
    --stdout-match "</properties>"
  )
  assertExitCode "${matches[@]}" 0 junitProperties "name=$rando" || return $?
}

test_jUnitRemaining() {
  local expected

  expected="$(printf "%s\n" '<property name="priority" value="1" />' '<property name="name" value="BLM" />')"
  assertEquals "$expected" "$(junitPropertyList "priority=1" "name=BLM")" || return $?

  assertEquals "<system-err>" "$(junitSystemErrorOpen)" || return $?
  assertEquals "</system-err>" "$(junitSystemErrorClose)" || return $?

  assertEquals "<system-out>" "$(junitSystemOutputOpen)" || return $?
  assertEquals "</system-out>" "$(junitSystemOutputClose)" || return $?

  assertEquals "<testcase a=\"b\">" "$(junitTestCaseOpen a=b)" || return $?
  assertEquals "</testcase>" "$(junitTestCaseClose)" || return $?

  assertEquals '<error>' "$(junitTestCaseErrorOpen)" || return $?
  assertEquals '<error message="This is the message">' "$(junitTestCaseErrorOpen "This is the message")" || return $?
  assertEquals '</error>' "$(junitTestCaseErrorClose "This is the message")" || return $?

  assertEquals '<failure>' "$(junitTestCaseFailureOpen)" || return $?
  assertEquals '<failure message="This is the message">' "$(junitTestCaseFailureOpen "This is the message")" || return $?
  assertEquals '</failure>' "$(junitTestCaseFailureClose "This is the message")" || return $?
  assertEquals '</failure>' "$(junitTestCaseFailureClose)" || return $?
  assertEquals '<skipped />' "$(junitTestCaseSkipped)" || return $?
  assertEquals '<skipped message="This is the message" />' "$(junitTestCaseSkipped "This is the message")" || return $?
}
