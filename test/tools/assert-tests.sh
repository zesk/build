#!/usr/bin/env bash
#
# assert-tests.sh
#
# Assertion testing
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
testOutputEquals() {
  assertExitCode --line "$LINENO" 0 assertOutputEquals --line "$LINENO" "a" printf "a" || return $?
  assertNotExitCode --stderr-ok --line "$LINENO" 0 assertOutputEquals --line "$LINENO" "a" printf "b" || return $?
}

testAssertEquality() {
  local errorCode

  errorCode=$(_code assert)
  assertExitCode --line "$LINENO" 0 assertEquals "aaa" "aaa" || return $?
  assertExitCode --line "$LINENO" --stderr-ok "$errorCode" assertEquals "aaa" "aab" || return $?
  assertExitCode --line "$LINENO" "0" assertContains "foo" "food distribution" || return $?
  assertExitCode --line "$LINENO" --stderr-ok "$errorCode" assertContains "foo" "good distribution" || return $?

  # Equals
  assertExitCode --line "$LINENO" 0 assertEquals "a" "a" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertEquals "a" "b" || return $?

  # Not Equals
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertNotEquals "a" "a" || return $?
  assertExitCode --line "$LINENO" 0 assertNotEquals "a" "b" || return $?

  # Contains
  assertExitCode --line "$LINENO" 0 assertContains "a" "abracadabra" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertContains "z" "abracadabra" || return $?

  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertNotContains "a" "abracadabra" || return $?
  assertExitCode --line "$LINENO" 0 assertNotContains "z" "abracadabra" || return $?
}

testAssertComparisons() {
  # Simple numbers
  assertExitCode --line "$LINENO" 0 assertGreaterThan 10 9 || return $?                   # a > b
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertGreaterThan 9 10 || return $?    # a > b
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertGreaterThan 100 100 || return $? # a > b

  assertExitCode --line "$LINENO" 0 assertGreaterThanOrEqual 10 9 || return $?                # a > b
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertGreaterThanOrEqual 9 10 || return $? # a > b
  assertExitCode --line "$LINENO" 0 assertGreaterThanOrEqual 100 100 || return $?             # a > b

  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertLessThan 10 9 || return $?    # a < b
  assertExitCode --line "$LINENO" 0 assertLessThan 9 10 || return $?                   # a < b
  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertLessThan 100 100 || return $? # a < b

  assertNotExitCode --line "$LINENO" --stderr-ok 0 assertLessThanOrEqual 10 9 || return $? # a <= b
  assertExitCode --line "$LINENO" 0 assertLessThanOrEqual 9 10 || return $?                # a <= b
  assertExitCode --line "$LINENO" 0 assertLessThanOrEqual 100 100 || return $?             # a <= b
}
