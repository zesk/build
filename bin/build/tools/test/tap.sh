#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 3
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testSuiteTAP_plan() {
  local testCount="$1"
  printf -- "%d%s%d\n" "$(incrementor 1 TAP_TEST)" ".." "$testCount"
}

__testSuiteTAP_line() {
  local status="$1" && shift
  local handler="returnMessage"
  local tapFile="${1-}"

  export __TEST_SUITE_RESULT

  [ -f "$tapFile" ] && shift 1 || throwEnvironment "$handler" "tapFile does not exist: $tapFile" || return $?

  local functionName="${1-}" source="${2-}" functionLine="${3-}" __flagText="${4-}"
  shift 4 || throwArgument "$handler" "Missing functionName source or functionLine" || return $?

  local directive="" value
  if isSubstringInsensitive ";Skip:true;" ";$__flagText;"; then
    directive="skip in test comment"
  fi
  if isSubstringInsensitive ";Ignore:true;" ";$__flagText;"; then
    directive="TODO Ignore test comment"
  fi
  value=$(bashFunctionCommentVariable "$source" "$functionName" "TODO") || :
  [ -z "$value" ] || directive="TODO ${value//$'\n'/ }"
  [ -z "$directive" ] || directive="$__TEST_SUITE_RESULT"
  [ -z "$directive" ] || directive="# $directive"
  printf -- "%s %d %s%s\n" "$status" "$(incrementor TAP_TEST)" "$functionName @ $source:$functionLine" "$directive" >>"$tapFile"
}

# Argument: tapFile - File. Required. The target output file.
# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
# Argument: flags - SemicolonList. Required. Flags from the test in the form
__testSuiteTAP_ok() {
  __testSuiteTAP_line "ok" "$@"
}

# Argument: tapFile - File. Required. The target output file.
# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
__testSuiteTAP_not_ok() {
  __testSuiteTAP_line "not ok" "$@"
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
