#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="stateFile - File. Required. File to access, must exist."$'\n'"name - EnvironmentVariable. Required. Name to read."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Read an array value from a state file"$'\n'"Outputs array elements, one per line."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/environment/io.sh"
fn="environmentValueReadArray"
fnMarker="environmentvaluereadarray"
foundNames=([0]="argument")
line="147"
rawComment="Read an array value from a state file"$'\n'"Argument: stateFile - File. Required. File to access, must exist."$'\n'"Argument: name - EnvironmentVariable. Required. Name to read."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs array elements, one per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="147"
summary="Read an array value from a state file"
summaryComputed="true"
usage="environmentValueReadArray stateFile name [ --help ]"
