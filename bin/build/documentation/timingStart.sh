#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs the offset in milliseconds from midnight UTC January 1, 1970."$'\n'""$'\n'"Only fails if \`date\` is not installed"$'\n'""$'\n'""
descriptionLineCount="4"
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Completed in\""$'\n'"    start=\$(timingStart) && printf \"%d\\n\" \"\$start\""$'\n'"    1777501474602"$'\n'""
file="bin/build/tools/timing.sh"
fn="timingStart"
fnMarker="timingstart"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires" [4]="stdout" [5]="output")
init=""
line="148"
output="1777501474602"$'\n'""
rawComment="Summary: Start a timer"$'\n'"Outputs the offset in milliseconds from midnight UTC January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingReport \"\$init\" \"Completed in\""$'\n'"Requires: __timestamp, returnEnvironment date"$'\n'"Example:     start=\$(timingStart) && printf \"%d\\n\" \"\$start\""$'\n'"Example:     1777501474602"$'\n'"stdout: UnsignedInteger"$'\n'"Output: 1777501474602"$'\n'"Only fails if \`date\` is not installed"$'\n'""$'\n'""
requires="__timestamp, returnEnvironment date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="148"
start="1777824804096"
stdout="UnsignedInteger"$'\n'""
summary="Start a timer"
summaryComputed=""
usage="timingStart [ --help ]"
