#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="duration - UnsignedInteger. Optional. Timing to output"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="timing.sh"
description="Output timing like \"1 day, 2 hours, 3 minutes, 4 seconds, 5 ms\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingDuration"
foundNames=([0]="argument")
line="177"
lowerFn="timingduration"
rawComment="Output timing like \"1 day, 2 hours, 3 minutes, 4 seconds, 5 ms\""$'\n'"Argument: duration - UnsignedInteger. Optional. Timing to output"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="e5841f7ef57a68876e79b7a4133c04a0ebe8d640"
sourceLine="177"
summary="Output timing like \"1 day, 2 hours, 3 minutes, 4"
summaryComputed="true"
usage="timingDuration [ duration ] [ --help ] [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingDuration'$'\e''[0m '$'\e''[[(blue)]m[ duration ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mduration           '$'\e''[[(value)]mUnsignedInteger. Optional. Timing to output'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingDuration [ duration ] [ --help ] [ --help ] [ --handler handler ]'$'\n'''$'\n''    duration           UnsignedInteger. Optional. Timing to output'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/timing.md"
