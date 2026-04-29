#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-29
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
description="Outputs the offset in milliseconds from midnight UTC January 1, 1970."$'\n'"Only fails if \`date\` is not installed"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Completed in\""$'\n'"    start=\$(timingStart) && printf \"%d\\n\" \"\$start\""$'\n'"    1777501474602"$'\n'""
file="bin/build/tools/timing.sh"
fn="timingStart"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires" [4]="stdout" [5]="output")
init=""
line="148"
lowerFn="timingstart"
output="1777501474602"$'\n'""
rawComment="Summary: Start a timer"$'\n'"Outputs the offset in milliseconds from midnight UTC January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingReport \"\$init\" \"Completed in\""$'\n'"Requires: __timestamp, returnEnvironment date"$'\n'"Example:     start=\$(timingStart) && printf \"%d\\n\" \"\$start\""$'\n'"Example:     1777501474602"$'\n'"stdout: UnsignedInteger"$'\n'"Output: 1777501474602"$'\n'"Only fails if \`date\` is not installed"$'\n'""$'\n'""
requires="__timestamp, returnEnvironment date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="148"
start="1777503067087"
stdout="UnsignedInteger"$'\n'""
summary="Start a timer"$'\n'""
usage="timingStart [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingStart'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs the offset in milliseconds from midnight UTC January 1, 1970.'$'\n''Only fails if '$'\e''[[(code)]mdate'$'\e''[[(reset)]m is not installed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Completed in"'$'\n''    start=$(timingStart) && printf "%d\n" "$start"'$'\n''    1777501474602'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingStart [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Outputs the offset in milliseconds from midnight UTC January 1, 1970.'$'\n''Only fails if date is not installed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Completed in"'$'\n''    start=$(timingStart) && printf "%d\n" "$start"'$'\n''    1777501474602'$'\n'''
documentationPath="documentation/source/tools/timing.md"
