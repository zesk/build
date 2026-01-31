#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
assertions=""
base="junit.sh"
description="Open tag for \`testsuites\`"$'\n'"Attributes:"$'\n'"- \`name=Test run\`"$'\n'"- \`tests=8\`"$'\n'"- \`failures=1\`"$'\n'"- \`errors=1\`"$'\n'"- \`skipped=1\`"$'\n'"- \`assertions=20\`"$'\n'"- \`time=16.082687\`"$'\n'"- \`timestamp=2021-04-02T15:48:23\`"$'\n'""
example="    <testsuites name=\"Test run\" tests=\"8\" failures=\"1\" errors=\"1\" skipped=\"1\""$'\n'"               assertions=\"20\" time=\"16.082687\" timestamp=\"2021-04-02T15:48:23\">"$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="example" [1]="argument")
rawComment="Open tag for \`testsuites\`"$'\n'"Example:     <testsuites name=\"Test run\" tests=\"8\" failures=\"1\" errors=\"1\" skipped=\"1\""$'\n'"Example:                assertions=\"20\" time=\"16.082687\" timestamp=\"2021-04-02T15:48:23\">"$'\n'"Attributes:"$'\n'"- \`name=Test run\`"$'\n'"- \`tests=8\`"$'\n'"- \`failures=1\`"$'\n'"- \`errors=1\`"$'\n'"- \`skipped=1\`"$'\n'"- \`assertions=20\`"$'\n'"- \`time=16.082687\`"$'\n'"- \`timestamp=2021-04-02T15:48:23\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="4fd2599400dc014b4a9975430b3488daec5ea2a9"
summary="Open tag for \`testsuites\`"
summaryComputed="true"
usage="junitOpen [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitOpen'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Open tag for '$'\e''[[(code)]mtestsuites'$'\e''[[(reset)]m'$'\n''Attributes:'$'\n''- '$'\e''[[(code)]mname=Test run'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtests=8'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfailures=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]merrors=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mskipped=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]massertions=20'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtime=16.082687'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtimestamp=2021-04-02T15:48:23'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"'$'\n''               assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: junitOpen [ --help ]'$'\n'''$'\n''    --help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Open tag for testsuites'$'\n''Attributes:'$'\n''- name=Test run'$'\n''- tests=8'$'\n''- failures=1'$'\n''- errors=1'$'\n''- skipped=1'$'\n''- assertions=20'$'\n''- time=16.082687'$'\n''- timestamp=2021-04-02T15:48:23'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"'$'\n''               assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">'$'\n'''
# elapsed 3.634
