#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
assertions=""
base="junit.sh"
description="Open tag for \`testsuite\`"$'\n'"Attributes:"$'\n'"- \`name=Tests.Registration\`"$'\n'"- \`tests=8\`"$'\n'"- \`failures=1\`"$'\n'"- \`errors=1\`"$'\n'"- \`skipped=1\`"$'\n'"- \`assertions=20\`"$'\n'"- \`time=16.082687\`"$'\n'"- \`timestamp=2021-04-02T15:48:23\`"$'\n'"- \`file=tests/registration.code\`"$'\n'""
example="    <testsuite name=\"Tests.Registration\" tests=\"8\" failures=\"1\" errors=\"1\" skipped=\"1\""$'\n'"         assertions=\"20\" time=\"16.082687\" timestamp=\"2021-04-02T15:48:23\""$'\n'"         file=\"tests/registration.code\">"$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="example" [1]="argument")
rawComment="Open tag for \`testsuite\`"$'\n'"Example:     <testsuite name=\"Tests.Registration\" tests=\"8\" failures=\"1\" errors=\"1\" skipped=\"1\""$'\n'"Example:          assertions=\"20\" time=\"16.082687\" timestamp=\"2021-04-02T15:48:23\""$'\n'"Example:          file=\"tests/registration.code\">"$'\n'"Attributes:"$'\n'"- \`name=Tests.Registration\`"$'\n'"- \`tests=8\`"$'\n'"- \`failures=1\`"$'\n'"- \`errors=1\`"$'\n'"- \`skipped=1\`"$'\n'"- \`assertions=20\`"$'\n'"- \`time=16.082687\`"$'\n'"- \`timestamp=2021-04-02T15:48:23\`"$'\n'"- \`file=tests/registration.code\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="99328da6c6125bd51b64fe5c2c945dbdee764a06"
summary="Open tag for \`testsuite\`"
summaryComputed="true"
usage="junitSuiteOpen [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitSuiteOpen'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Open tag for '$'\e''[[(code)]mtestsuite'$'\e''[[(reset)]m'$'\n''Attributes:'$'\n''- '$'\e''[[(code)]mname=Tests.Registration'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtests=8'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfailures=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]merrors=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mskipped=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]massertions=20'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtime=16.082687'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtimestamp=2021-04-02T15:48:23'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfile=tests/registration.code'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    <testsuite name="Tests.Registration" tests="8" failures="1" errors="1" skipped="1"'$'\n''         assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23"'$'\n''         file="tests/registration.code">'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: junitSuiteOpen [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Open tag for testsuite'$'\n''Attributes:'$'\n''- name=Tests.Registration'$'\n''- tests=8'$'\n''- failures=1'$'\n''- errors=1'$'\n''- skipped=1'$'\n''- assertions=20'$'\n''- time=16.082687'$'\n''- timestamp=2021-04-02T15:48:23'$'\n''- file=tests/registration.code'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    <testsuite name="Tests.Registration" tests="8" failures="1" errors="1" skipped="1"'$'\n''         assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23"'$'\n''         file="tests/registration.code">'$'\n'''
