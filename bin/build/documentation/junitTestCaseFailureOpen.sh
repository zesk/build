#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="message - Optional. String. Why failure occurred."$'\n'""
base="junit.sh"
description="Open tag for \`failure\` - test failed"$'\n'"Argument ... - String. Optional. Name/value tag attributes"$'\n'"Attributes:"$'\n'"- \`type=AssertionError\`"$'\n'""
example="    <failure message=\"Expected value did not match.\" type=\"AssertionError\">"$'\n'"        Failure description or stack trace"$'\n'"    </failure>"$'\n'""
file="bin/build/tools/junit.sh"
fn="junitTestCaseFailureOpen"
foundNames=([0]="example" [1]="argument")
line="265"
lowerFn="junittestcasefailureopen"
rawComment="Open tag for \`failure\` - test failed"$'\n'"Example:     <failure message=\"Expected value did not match.\" type=\"AssertionError\">"$'\n'"Example:         Failure description or stack trace"$'\n'"Example:     </failure>"$'\n'"Argument: message - Optional. String. Why failure occurred."$'\n'"Argument ... - String. Optional. Name/value tag attributes"$'\n'"Attributes:"$'\n'"- \`type=AssertionError\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="265"
summary="Open tag for \`failure\` - test failed"
summaryComputed="true"
usage="junitTestCaseFailureOpen [ message ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitTestCaseFailureOpen'$'\e''[0m '$'\e''[[(blue)]m[ message ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmessage  '$'\e''[[(value)]mOptional. String. Why failure occurred.'$'\e''[[(reset)]m'$'\n'''$'\n''Open tag for '$'\e''[[(code)]mfailure'$'\e''[[(reset)]m - test failed'$'\n''Argument ... - String. Optional. Name/value tag attributes'$'\n''Attributes:'$'\n''- '$'\e''[[(code)]mtype=AssertionError'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    <failure message="Expected value did not match." type="AssertionError">'$'\n''        Failure description or stack trace'$'\n''    </failure>'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: junitTestCaseFailureOpen [ message ]'$'\n'''$'\n''    message  Optional. String. Why failure occurred.'$'\n'''$'\n''Open tag for failure - test failed'$'\n''Argument ... - String. Optional. Name/value tag attributes'$'\n''Attributes:'$'\n''- type=AssertionError'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    <failure message="Expected value did not match." type="AssertionError">'$'\n''        Failure description or stack trace'$'\n''    </failure>'$'\n'''
documentationPath="documentation/source/tools/junit.md"
