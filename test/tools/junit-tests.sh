#!/usr/bin/env bash
#
# Tests for jUnit
#
# Copyright &copy; 2025 Market Acumen, Inc.

test_jUnitBasic() {
  local handler="returnMessage"

  local rando

  rando=$(__catch "$handler" randomString) || return $?

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
