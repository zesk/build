#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# tap.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testSuiteTAP_plan() {
  local cachePath="$1" && shift
  local testCount="$1"
  muzzle incrementor --path "$cachePath" 0 TAP_TEST
  printf -- "%d%s%d\n" "1" ".." "$testCount"
}

__testSuiteTAP_bail() {
  local reason="${1-}" && shift
  [ -z "$reason" ] || reason=" ${reason# }"
  printf -- "%s%s\n" "Bail out!" "$reason"
}

__testSuiteTAP_ParseFlags() {
  local directive=""
  if stringFoundInsensitive ";Skip:true;" ";$1;"; then
    directive="SKIP in test comment"
  fi
  if stringFoundInsensitive ";Ignore:true;" ";$1;"; then
    directive="TODO Ignore test comment"
  fi
  printf "%s\n" "$directive"
  [ -n "$directive" ]
}

__testSuiteTAP_line() {
  local status="$1" && shift
  local cachePath="$1" && shift
  local suiteName="$1" && shift
  local functionName="$1" && shift
  local functionFile="$1" && shift
  local functionLine="$1" && shift
  local directive="$1" && shift

  [ -z "$directive" ] || directive=" # $directive"
  local suffix="$*"
  [ -z "$suffix" ] || suffix=" $suffix"
  printf -- "%s %d - %s%s%s\n" "$status" "$(incrementor --path "$cachePath" TAP_TEST)" "[$suiteName] $functionName @ $functionFile:$functionLine" "$directive" "$suffix"
}

# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
# Argument: flags - SemicolonList. Required. Flags from the test in the form
__testSuiteTAP_ok() {
  local cachePath="$1" && shift
  local suiteName="$1" && shift
  local functionName="$1" && shift
  local functionFile="$1" && shift
  local functionLine="$1" && shift
  __testSuiteTAP_line "ok" "$cachePath" "$suiteName" "$functionName" "$functionFile" "$functionLine" "$@"
}

# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
# Argument: directive - String. Optional. Directive for TAP line.
__testSuiteTAP_skip() {
  local cachePath="$1" && shift
  local suiteName="$1" && shift
  local functionName="$1" && shift
  local functionFile="$1" && shift
  local functionLine="$1" && shift
  if [ $# -eq 0 ] || ! stringBeginsInsensitive "$1" "skip"; then
    set -- "SKIP" "$@"
  fi
  __testSuiteTAP_line "ok" "$cachePath" "$suiteName" "$functionName" "$functionFile" "$functionLine" "$@"
}

# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
# Argument: directive - String. Optional. Directive for TAP line.
__testSuiteTAP_not_ok() {
  local cachePath="$1" && shift
  local suiteName="$1" && shift
  local functionName="$1" && shift
  local functionFile="$1" && shift
  local functionLine="$1" && shift
  __testSuiteTAP_line "not ok" "$cachePath" "$suiteName" "$functionName" "$functionFile" "$functionLine" "$@"
}

# TODO: https://github.com/Perl-Toolchain-Gang/Test-Harness/blob/master/reference/Test-Harness-2.64/lib/Test/Harness/TAP.pod#php
# Argument: --tap - Flag. Optional. TAP output instead of console output.
#
# TAP's general format is:
#
#    1..N
#    ok 1 Description # Directive
#    not ok 2 Something
#    # Diagnostic
#    ....
#    ok 47 Description
#    ok 48 Description
#    more tests....
#
# TAP syntax:
#
#     1..N
#
# N is number of tests
#
# Directives for comments in descriptions:
#
#     not ok 2 # skip No processor installed.
#     not ok 3 # SKIP Note case does not matter
#
# Terminate testing:
#
#     Bail out!
#
# Test may pass or fail:
#
#     not ok 2 # TO DO This test may pass when Intel ships ARM chips
#
# Not the words TO and DO are together but are not here to avoid having this show up as a thing to do in the IDE.
#
