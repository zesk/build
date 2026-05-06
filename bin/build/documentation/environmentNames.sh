#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List names of environment values set in a bash state file"$'\n'""$'\n'""
descriptionLineCount="2"
example="    environmentNames < \"\$stateFile\""$'\n'""
file="bin/build/tools/environment/io.sh"
fn="environmentNames"
fnMarker="environmentnames"
foundNames=([0]="example" [1]="argument")
line="165"
rawComment="Example:     {fn} < \"\$stateFile\""$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"List names of environment values set in a bash state file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="165"
summary="List names of environment values set in a bash state"
summaryComputed="true"
usage="environmentNames [ --help ]"
