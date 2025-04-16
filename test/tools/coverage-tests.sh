#!/usr/bin/env bash
#
# coverage-tests.sh
#
# Coverage tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Leak: BASH_ARGC
# Leak: BASH_ARGV
testCoverageBasics() {
  assertExitCode --dump --stdout-match "Collecting coverage to" --stdout-match "Coverage completed" 0 bashCoverage --verbose isInteger 2 || return $?
}

#
testCoverageNeedToUpdate() {
  local home

  home=$(__environment buildHome) || return $?
  # THIS FAILS - INFINITE LOOP
  # assertExitCode --dump --stdout-match "Target is" --stdout-match "Coverage completed" 0 bashCoverage "$home/bin/build/tools.sh" isInteger 2 || return $?
  assertEquals "$home" "$home" || return $?
}

testCoverageReportThing() {
  local codes expected template

  codes=$(printf "%s\n" "return" "1")

  template="$(__bashCoverageReportTemplate "not-covered.html")"
  expected='&nbsp;&nbsp;[&nbsp;$#&nbsp;-gt&nbsp;0&nbsp;]&nbsp;||&nbsp;<em>return</em>&nbsp;<em>1</em>'
  assertEquals "$(__bashCoveragePartialLine '  [ $# -gt 0 ] || return 1' "$codes" "$template")" "$expected" || return $?

  codes=$(printf "%s\n" '[ $# -gt 0 ]')
  expected='&nbsp;&nbsp;<em>[&nbsp;$#&nbsp;-gt&nbsp;0&nbsp;]</em>&nbsp;||&nbsp;return&nbsp;1'
  assertEquals "$(__bashCoveragePartialLine '  [ $# -gt 0 ] || return 1' "$codes" "$template")" "$expected" || return $?
}
