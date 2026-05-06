#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="stateFile - EnvironmentFile. Required. File to read a value from."$'\n'"name - EnvironmentVariable. Required. Variable to read."$'\n'"default - EmptyString. Optional. Default value of the environment variable if it does not exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="No documentation for \`environmentValueRead\`."$'\n'""
descriptionLineCount=""
file="bin/build/tools/environment/io.sh"
fn="environmentValueRead"
fnMarker="environmentvalueread"
foundNames=([0]="argument" [1]="return_code")
line="89"
rawComment="Argument: stateFile - EnvironmentFile. Required. File to read a value from."$'\n'"Argument: name - EnvironmentVariable. Required. Variable to read."$'\n'"Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)"$'\n'"Return Code: 0 - If value"$'\n'""$'\n'""
return_code="1 - If value is not found and no default argument is supplied (2 arguments)"$'\n'"0 - If value"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="89"
summary="undocumented"
summaryComputed=""
usage="environmentValueRead stateFile name [ default ] [ --help ]"
