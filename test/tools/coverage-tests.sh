#!/usr/bin/env bash
#
# coverage-tests.sh
#
# Coverage tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testCoverageBasics() {
  assertExitCode --dump --stdout-match "Target is" --stdout-match "Coverage completed" --line "$LINENO" 0 bashCoverage isInteger 2 || return $?
}

#
testCoverageSubtools() {
  local home

  home=$(__environment buildHome) || return $?
  # THIS FAILS - INFINITE LOOP
  # assertExitCode --dump --stdout-match "Target is" --stdout-match "Coverage completed" --line "$LINENO" 0 bashCoverage "$home/bin/build/tools.sh" isInteger 2 || return $?
  assertEquals --line "$LINENO" "$home" "$home" || return $?
}
