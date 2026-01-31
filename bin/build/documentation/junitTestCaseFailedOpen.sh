#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="message - Required. Why failure occurred."$'\n'""
base="junit.sh"
description="Open tag for \`failure\` - test failed"$'\n'"Argument ... - String. Optional. failure description."$'\n'"Attributes:"$'\n'"- \`type=AssertionError\`"$'\n'""
example="    <failure message=\"Expected value did not match.\" type=\"AssertionError\">"$'\n'"        Failure description or stack trace"$'\n'"    </failure>"$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="example" [1]="argument")
rawComment="Open tag for \`failure\` - test failed"$'\n'"Example:     <failure message=\"Expected value did not match.\" type=\"AssertionError\">"$'\n'"Example:         Failure description or stack trace"$'\n'"Example:     </failure>"$'\n'"Argument: message - Required. Why failure occurred."$'\n'"Argument ... - String. Optional. failure description."$'\n'"Attributes:"$'\n'"- \`type=AssertionError\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="99328da6c6125bd51b64fe5c2c945dbdee764a06"
summary="Open tag for \`failure\` - test failed"
summaryComputed="true"
usage="junitTestCaseFailedOpen message"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitTestCaseFailedOpen'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mmessage'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mmessage  '$'\e''[[(value)]mRequired. Why failure occurred.'$'\e''[[(reset)]m'$'\n'''$'\n''Open tag for '$'\e''[[(code)]mfailure'$'\e''[[(reset)]m - test failed'$'\n''Argument ... - String. Optional. failure description.'$'\n''Attributes:'$'\n''- '$'\e''[[(code)]mtype=AssertionError'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    <failure message="Expected value did not match." type="AssertionError">'$'\n''        Failure description or stack trace'$'\n''    </failure>'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: junitTestCaseFailedOpen message'$'\n'''$'\n''    message  Required. Why failure occurred.'$'\n'''$'\n''Open tag for failure - test failed'$'\n''Argument ... - String. Optional. failure description.'$'\n''Attributes:'$'\n''- type=AssertionError'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    <failure message="Expected value did not match." type="AssertionError">'$'\n''        Failure description or stack trace'$'\n''    </failure>'$'\n'''
# elapsed 0.763
