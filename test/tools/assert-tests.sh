#!/usr/bin/env bash
#
# assert-tests.sh
#
# Assertion testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

# IDENTICAL errorEnvironment 1
errorEnvironment=1

tests+=(testAssertEquality)

testAssertEquality() {
  assertExitCode 0 assertEquals "aaa" "aaa" || return $?
  assertExitCode --stderr-ok "$errorEnvironment" assertEquals "aaa" "aab" || return $?
  assertExitCode "0" assertContains "foo" "food distribution" || return $?
  assertExitCode --stderr-ok "$errorEnvironment" assertContains "foo" "good distribution" || return $?

  # Equals
  assertExitCode 0 assertEquals "a" "a" || return $?
  assertNotExitCode --stderr-ok 0 assertEquals "a" "b" || return $?

  # Not Equals
  assertNotExitCode --stderr-ok 0 assertNotEquals "a" "a" || return $?
  assertExitCode 0 assertNotEquals "a" "b" || return $?

  # Contains
  assertExitCode 0 assertContains "a" "abracadabra" || return $?
  assertNotExitCode --stderr-ok 0 assertContains "z" "abracadabra" || return $?

  assertNotExitCode --stderr-ok 0 assertNotContains "a" "abracadabra" || return $?
  assertExitCode 0 assertNotContains "z" "abracadabra" || return $?
}

tests+=(testAssertComparisons)
testAssertComparisons() {
  # Simple numbers
  assertExitCode 0 assertGreaterThan 10 9 || return $?                   # a > b
  assertNotExitCode --stderr-ok 0 assertGreaterThan 9 10 || return $?    # a > b
  assertNotExitCode --stderr-ok 0 assertGreaterThan 100 100 || return $? # a > b

  assertExitCode 0 assertGreaterThanOrEqual 10 9 || return $?                # a > b
  assertNotExitCode --stderr-ok 0 assertGreaterThanOrEqual 9 10 || return $? # a > b
  assertExitCode 0 assertGreaterThanOrEqual 100 100 || return $?             # a > b

  assertNotExitCode --stderr-ok 0 assertLessThan 10 9 || return $?    # a < b
  assertExitCode 0 assertLessThan 9 10 || return $?                   # a < b
  assertNotExitCode --stderr-ok 0 assertLessThan 100 100 || return $? # a < b

  assertNotExitCode --stderr-ok 0 assertLessThanOrEqual 10 9 || return $? # a <= b
  assertExitCode 0 assertLessThanOrEqual 9 10 || return $?                # a <= b
  assertExitCode 0 assertLessThanOrEqual 100 100 || return $?             # a <= b
}
