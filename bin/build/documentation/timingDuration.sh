#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'duration - UnsignedInteger. Optional. Timing to output\n--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--stop stopUnit - String. Optional. Stop displaying fractional output after this unit is displayed.\n'
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"\n\n'
descriptionLineCount="2"
file="bin/build/tools/timing.sh"
fn="timingDuration"
fnMarker="timingduration"
foundNames=([0]="argument")
line="191"
rawComment=$'Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"\nArgument: duration - UnsignedInteger. Optional. Timing to output\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --stop stopUnit - String. Optional. Stop displaying fractional output after this unit is displayed.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="191"
summary="Output timing like \"1 day, 2 hours, 3 minutes, 4"
summaryComputed="true"
usage="timingDuration [ duration ] [ --help ] [ --handler handler ] [ --stop stopUnit ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingDuration'$'\e''[0m '$'\e''[[(blue)]m[ duration ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --stop stopUnit ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mduration           '$'\e''[[(value)]mUnsignedInteger. Optional. Timing to output'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--stop stopUnit    '$'\e''[[(value)]mString. Optional. Stop displaying fractional output after this unit is displayed.'$'\e''[[(reset)]m'$'\n'''$'\n''Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: timingDuration [ duration ] [ --help ] [ --handler handler ] [ --stop stopUnit ]'$'\n'''$'\n''    duration           UnsignedInteger. Optional. Timing to output'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --stop stopUnit    String. Optional. Stop displaying fractional output after this unit is displayed.'$'\n'''$'\n''Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/timing.md"
