#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'command - Executable. Required. Command to run.\n--help - Flag. Optional. Display this help.\n--name - String. Optional. Display this help.\n--slow slowMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold.\n--fast fastMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold.\n'
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Time command, similar to `time` but uses internal functions\nOutputs time as `timingReport`\n\n'
descriptionLineCount="3"
file="bin/build/tools/timing.sh"
fn="timing"
fnMarker="timing"
foundNames=([0]="argument")
line="16"
rawComment=$'Time command, similar to `time` but uses internal functions\nArgument: command - Executable. Required. Command to run.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --name - String. Optional. Display this help.\nArgument: --slow slowMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold.\nArgument: --fast fastMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold.\nOutputs time as `timingReport`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/timing.sh"
sourceHash="9e40eda58cb5d6b2e9cfe47357e22988f32ada87"
sourceLine="16"
summary="Time command, similar to \`time\` but uses internal functions"
summaryComputed="true"
usage="timing command [ --help ] [ --name ] [ --slow slowMilliseconds ] [ --fast fastMilliseconds ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtiming'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --name ]'$'\e''[0m '$'\e''[[(blue)]m[ --slow slowMilliseconds ]'$'\e''[0m '$'\e''[[(blue)]m[ --fast fastMilliseconds ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcommand                  '$'\e''[[(value)]mExecutable. Required. Command to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name                   '$'\e''[[(value)]mString. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--slow slowMilliseconds  '$'\e''[[(value)]mUnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fast fastMilliseconds  '$'\e''[[(value)]mUnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold.'$'\e''[[(reset)]m'$'\n'''$'\n''Time command, similar to '$'\e''[[(code)]mtime'$'\e''[[(reset)]m but uses internal functions'$'\n''Outputs time as '$'\e''[[(code)]mtimingReport'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: timing command [ --help ] [ --name ] [ --slow slowMilliseconds ] [ --fast fastMilliseconds ]'$'\n'''$'\n''    command                  Executable. Required. Command to run.'$'\n''    --help                   Flag. Optional. Display this help.'$'\n''    --name                   String. Optional. Display this help.'$'\n''    --slow slowMilliseconds  UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold.'$'\n''    --fast fastMilliseconds  UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold.'$'\n'''$'\n''Time command, similar to time but uses internal functions'$'\n''Outputs time as timingReport'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/timing.md"
