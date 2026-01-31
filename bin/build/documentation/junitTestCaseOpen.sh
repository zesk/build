#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="junit.sh"
description="Open tag for \`testcase\` - Test case"$'\n'"- \`name=testCase1\`"$'\n'"- \`classname=Tests.Registration\`"$'\n'"- \`assertions=2\`"$'\n'"- \`time=2.436\`"$'\n'"- \`file=tests/registration.code\`"$'\n'"- \`line=24\`"$'\n'""
example="    <testcase name=\"testCase1\" classname=\"Tests.Registration\" assertions=\"2\""$'\n'"        time=\"2.436\" file=\"tests/registration.code\" line=\"24\"/>"$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="example")
rawComment="Open tag for \`testcase\` - Test case"$'\n'"Example:     <testcase name=\"testCase1\" classname=\"Tests.Registration\" assertions=\"2\""$'\n'"Example:         time=\"2.436\" file=\"tests/registration.code\" line=\"24\"/>"$'\n'"- \`name=testCase1\`"$'\n'"- \`classname=Tests.Registration\`"$'\n'"- \`assertions=2\`"$'\n'"- \`time=2.436\`"$'\n'"- \`file=tests/registration.code\`"$'\n'"- \`line=24\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="99328da6c6125bd51b64fe5c2c945dbdee764a06"
summary="Open tag for \`testcase\` - Test case"
summaryComputed="true"
time=""
usage="junitTestCaseOpen"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitTestCaseOpen'$'\e''[0m'$'\n'''$'\n''Open tag for '$'\e''[[(code)]mtestcase'$'\e''[[(reset)]m - Test case'$'\n''- '$'\e''[[(code)]mname=testCase1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mclassname=Tests.Registration'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]massertions=2'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtime=2.436'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfile=tests/registration.code'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mline=24'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    <testcase name="testCase1" classname="Tests.Registration" assertions="2"'$'\n''        time="2.436" file="tests/registration.code" line="24"/>'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: junitTestCaseOpen'$'\n'''$'\n''Open tag for testcase - Test case'$'\n''- name=testCase1'$'\n''- classname=Tests.Registration'$'\n''- assertions=2'$'\n''- time=2.436'$'\n''- file=tests/registration.code'$'\n''- line=24'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    <testcase name="testCase1" classname="Tests.Registration" assertions="2"'$'\n''        time="2.436" file="tests/registration.code" line="24"/>'$'\n'''
# elapsed 0.622
