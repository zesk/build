#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.\n--help - Flag. Optional. Display this help.\n'
assertions=""
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Open tag for `testsuites`\n\nAttributes:\n- `name=Test run`\n- `tests=8`\n- `failures=1`\n- `errors=1`\n- `skipped=1`\n- `assertions=20`\n- `time=16.082687`\n- `timestamp=2021-04-02T15:48:23`\n\n'
descriptionLineCount="12"
example=$'    <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"\n               assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">\n'
file="bin/build/tools/junit.sh"
fn="junitOpen"
fnMarker="junitopen"
foundNames=([0]="example" [1]="argument")
line="29"
rawComment=$'Open tag for `testsuites`\nExample:     <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"\nExample:                assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">\nAttributes:\n- `name=Test run`\n- `tests=8`\n- `failures=1`\n- `errors=1`\n- `skipped=1`\n- `assertions=20`\n- `time=16.082687`\n- `timestamp=2021-04-02T15:48:23`\nArgument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="29"
summary="Open tag for \`testsuites\`"
summaryComputed="true"
usage="junitOpen [ nameValue ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitOpen'$'\e''[0m '$'\e''[[(blue)]m[ nameValue ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mnameValue ...  '$'\e''[[(value)]mOptional. String. A list of name value pairs (unquoted) to output as XML '$'\e''[[(code)]mproperty'$'\e''[[(reset)]m tags.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Open tag for '$'\e''[[(code)]mtestsuites'$'\e''[[(reset)]m'$'\n'''$'\n''Attributes:'$'\n''- '$'\e''[[(code)]mname=Test run'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtests=8'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfailures=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]merrors=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mskipped=1'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]massertions=20'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtime=16.082687'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtimestamp=2021-04-02T15:48:23'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"'$'\n''               assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">'
# shellcheck disable=SC2016
helpPlain='Usage: junitOpen [ nameValue ... ] [ --help ]'$'\n'''$'\n''    nameValue ...  Optional. String. A list of name value pairs (unquoted) to output as XML property tags.'$'\n''    --help         Flag. Optional. Display this help.'$'\n'''$'\n''Open tag for testsuites'$'\n'''$'\n''Attributes:'$'\n''- name=Test run'$'\n''- tests=8'$'\n''- failures=1'$'\n''- errors=1'$'\n''- skipped=1'$'\n''- assertions=20'$'\n''- time=16.082687'$'\n''- timestamp=2021-04-02T15:48:23'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"'$'\n''               assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">'
documentationPath="documentation/source/tools/junit.md"
