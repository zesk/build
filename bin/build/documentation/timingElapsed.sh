#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
description="Show elapsed time from a start time"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingElapsed \"\$init\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingElapsed"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
init=""
rawComment="Summary: Show elapsed time from a start time"$'\n'"Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingElapsed \"\$init\""$'\n'"Requires: __timestamp returnEnvironment validate date"$'\n'""$'\n'""
requires="__timestamp returnEnvironment validate date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="a2dd1cac5294f71154fbfa2d171e81f150251ed4"
summary="Show elapsed time from a start time"$'\n'""
usage="timingElapsed timingOffset [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingElapsed'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtimingOffset'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtimingOffset  '$'\e''[[(value)]mUnsignedInteger. Required. Offset in milliseconds from January 1, 1970.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show elapsed time from a start time'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingElapsed "$init"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingElapsed timingOffset [ --help ]'$'\n'''$'\n''    timingOffset  UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Show elapsed time from a start time'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingElapsed "$init"'$'\n'''
