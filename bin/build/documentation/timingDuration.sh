#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="duration - UnsignedInteger. Optional. Timing to output"$'\n'"--stop unit - String. Optional. Stop computation and display at this unit."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="timing.sh"
description="Output timing like \"1 day, 2 hours, 3 minutes, 4 seconds, 5 ms\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingDuration"
foundNames=([0]="argument")
rawComment="Output timing like \"1 day, 2 hours, 3 minutes, 4 seconds, 5 ms\""$'\n'"Argument: duration - UnsignedInteger. Optional. Timing to output"$'\n'"Argument: --stop unit - String. Optional. Stop computation and display at this unit."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="f783345c9632fff6bf787e6f257d7886528addeb"
summary="Output timing like \"1 day, 2 hours, 3 minutes, 4"
summaryComputed="true"
usage="timingDuration [ duration ] [ --stop unit ] [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingDuration'$'\e''[0m '$'\e''[[(blue)]m[ duration ]'$'\e''[0m '$'\e''[[(blue)]m[ --stop unit ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mduration           '$'\e''[[(value)]mUnsignedInteger. Optional. Timing to output'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--stop unit        '$'\e''[[(value)]mString. Optional. Stop computation and display at this unit.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingDuration [ duration ] [ --stop unit ] [ --help ] [ --handler handler ]'$'\n'''$'\n''    duration           UnsignedInteger. Optional. Timing to output'$'\n''    --stop unit        String. Optional. Stop computation and display at this unit.'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
