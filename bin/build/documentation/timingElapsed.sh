#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Show elapsed time from a start time"
descriptionLineCount=""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingElapsed \"\$init\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingElapsed"
fnMarker="timingelapsed"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires" [4]="stdout" [5]="output")
init=""
line="122"
output="4232"$'\n'""
rawComment="Summary: Show elapsed time from a start time"$'\n'"Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingElapsed \"\$init\""$'\n'"Requires: __timestamp returnEnvironment validate date"$'\n'"stdout: UnsignedInteger"$'\n'"Output: 4232"$'\n'""$'\n'""
requires="__timestamp returnEnvironment validate date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="122"
stdout="UnsignedInteger"$'\n'""
summary="Show elapsed time from a start time"
summaryComputed=""
usage="timingElapsed timingOffset [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingElapsed'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtimingOffset'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtimingOffset  '$'\e''[[(value)]mUnsignedInteger. Required. Offset in milliseconds from January 1, 1970.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show elapsed time from a start time'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingElapsed "$init"'
# shellcheck disable=SC2016
helpPlain='Usage: timingElapsed timingOffset [ --help ]'$'\n'''$'\n''    timingOffset  UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Show elapsed time from a start time'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingElapsed "$init"'
documentationPath="documentation/source/tools/timing.md"
