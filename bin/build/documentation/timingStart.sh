#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs the offset in milliseconds from midnight UTC January 1, 1970.\n\nOnly fails if `date` is not installed\n\n'
descriptionLineCount="4"
example=$'    init=$(timingStart)\n    ...\n    timingReport "$init" "Completed in"\n    start=$(timingStart) && printf "%d\\n" "$start"\n    1777501474602\n'
file="bin/build/tools/timing.sh"
fn="timingStart"
fnMarker="timingstart"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires" [4]="stdout" [5]="output")
init=""
line="148"
output=$'1777501474602\n'
rawComment=$'Summary: Start a timer\nOutputs the offset in milliseconds from midnight UTC January 1, 1970.\nArgument: --help - Flag. Optional. Display this help.\nExample:     init=$(timingStart)\nExample:     ...\nExample:     timingReport "$init" "Completed in"\nRequires: __timestamp, returnEnvironment date\nExample:     start=$(timingStart) && printf "%d\\n" "$start"\nExample:     1777501474602\nstdout: UnsignedInteger\nOutput: 1777501474602\nOnly fails if `date` is not installed\n\n'
requires=$'__timestamp, returnEnvironment date\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/timing.sh"
sourceHash="9e40eda58cb5d6b2e9cfe47357e22988f32ada87"
sourceLine="148"
start="1781840386506"
stdout=$'UnsignedInteger\n'
summary="Start a timer"
summaryComputed=""
usage="timingStart [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingStart'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs the offset in milliseconds from midnight UTC January 1, 1970.'$'\n'''$'\n''Only fails if '$'\e''[[(code)]mdate'$'\e''[[(reset)]m is not installed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Completed in"'$'\n''    start=$(timingStart) && printf "%d\n" "$start"'$'\n''    1777501474602'
# shellcheck disable=SC2016
helpPlain='Usage: timingStart [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Outputs the offset in milliseconds from midnight UTC January 1, 1970.'$'\n'''$'\n''Only fails if date is not installed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Completed in"'$'\n''    start=$(timingStart) && printf "%d\n" "$start"'$'\n''    1777501474602'
documentationPath="documentation/source/tools/timing.md"
