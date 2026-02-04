#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# assert-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testOutputEquals() {
  assertExitCode 0 assertOutputEquals --line "$LINENO" "a" printf "a" || return $?
  assertNotExitCode --stderr-ok --line "$LINENO" 0 assertOutputEquals --line "$LINENO" "a" printf "b" || return $?
}

testAssertEquality() {
  local errorCode

  errorCode=$(returnCode assert)
  assertExitCode 0 assertEquals "aaa" "aaa" || return $?
  assertExitCode --stderr-ok "$errorCode" assertEquals "aaa" "aab" || return $?
  assertExitCode "0" assertContains "foo" "food distribution" || return $?
  assertExitCode --stderr-ok "$errorCode" assertContains "foo" "good distribution" || return $?

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

testAssertComparisons() {
  local handler="returnMessage"
  local tempError

  tempError=$(fileTemporaryName "$handler") || return $?
  exec 2>"$tempError"
  # Simple numbers
  assertExitCode 0 assertGreaterThan --line "$LINENO" 10 9 || return $? # a > b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?

  assertNotExitCode --stderr-ok 0 assertGreaterThan --line "$LINENO" 9 10 || return $? # a > b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertNotExitCode --stderr-ok 0 assertGreaterThan --line "$LINENO" 100 100 || return $? # a > b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?

  assertExitCode 0 assertGreaterThanOrEqual --line "$LINENO" 10 9 || return $? # a > b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertNotExitCode --stderr-ok 0 assertGreaterThanOrEqual --line "$LINENO" 9 10 || return $? # a > b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertExitCode 0 assertGreaterThanOrEqual --line "$LINENO" 100 100 || return $? # a > b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?

  assertNotExitCode --stderr-ok 0 assertLessThan --line "$LINENO" 10 9 || return $? # a < b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertExitCode 0 assertLessThan 9 10 || return $? # a < b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertNotExitCode --stderr-ok 0 assertLessThan 100 100 || return $? # a < b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?

  assertNotExitCode --stderr-ok 0 assertLessThanOrEqual --line "$LINENO" 10 9 || return $? # a <= b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertExitCode 0 assertLessThanOrEqual --line "$LINENO" 9 10 || return $? # a <= b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?
  assertExitCode 0 assertLessThanOrEqual --line "$LINENO" 100 100 || return $? # a <= b
  fileIsEmpty "$tempError" || throwEnvironment "$handler" "last test output stderr" "$(dumpPipe <"$tempError")" || return $?

  catchEnvironment "$handler" rm -f "$tempError" || return $?
}

testZeroFile() {
  local handler="returnMessage"
  local tempFile

  tempFile=$(fileTemporaryName "$handler") || return $?

  local assertCode && returnAssert || assertCode=$?

  assertFileExists "$tempFile" || return $?
  assertExitCode --stderr-ok "$assertCode" assertNotZeroFileSize "$tempFile" || return $?
  assertZeroFileSize "$tempFile" || return $?
   catchEnvironment "$handler" printf "%s\n" "1" >"$tempFile" || return $?
  assertExitCode --stderr-ok "$assertCode" assertZeroFileSize "$tempFile" || return $?
  assertNotZeroFileSize "$tempFile" || return $?

  catchEnvironment "$handler" rm -f "$tempFile" || return $?
}
