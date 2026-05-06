#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="command - Executable. Required. Command to run."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--name - String. Optional. Display this help."$'\n'"--slow slowMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold."$'\n'"--fast fastMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold."$'\n'""
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Time command, similar to \`time\` but uses internal functions"$'\n'"Outputs time as \`timingReport\`"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/timing.sh"
fn="timing"
fnMarker="timing"
foundNames=([0]="argument")
line="16"
rawComment="Time command, similar to \`time\` but uses internal functions"$'\n'"Argument: command - Executable. Required. Command to run."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --name - String. Optional. Display this help."$'\n'"Argument: --slow slowMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold."$'\n'"Argument: --fast fastMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold."$'\n'"Outputs time as \`timingReport\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="16"
summary="Time command, similar to \`time\` but uses internal functions"
summaryComputed="true"
usage="timing command [ --help ] [ --name ] [ --slow slowMilliseconds ] [ --fast fastMilliseconds ]"
