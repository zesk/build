#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="name - String. Required. Name to write."$'\n'"value - EmptyString. Optional. Value to write."$'\n'"... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Write a value to a state file as NAME=\"value\""$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/environment/io.sh"
fn="environmentValueWrite"
fnMarker="environmentvaluewrite"
foundNames=([0]="argument")
line="13"
rawComment="Write a value to a state file as NAME=\"value\""$'\n'"Argument: name - String. Required. Name to write."$'\n'"Argument: value - EmptyString. Optional. Value to write."$'\n'"Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="13"
summary="Write a value to a state file as NAME=\"value\""
summaryComputed="true"
usage="environmentValueWrite name [ value ] [ ... ] [ --help ]"
