#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="encodedValue - String. Required. Value to convert to tokens, one per line"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Convert an array value which was loaded already"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/environment/io.sh"
fn="environmentValueConvertArray"
fnMarker="environmentvalueconvertarray"
foundNames=([0]="argument" [1]="stdout")
line="117"
rawComment="Convert an array value which was loaded already"$'\n'"Argument: encodedValue - String. Required. Value to convert to tokens, one per line"$'\n'"stdout: Array values separated by newlines"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="117"
stdout="Array values separated by newlines"$'\n'""
summary="Convert an array value which was loaded already"
summaryComputed="true"
usage="environmentValueConvertArray encodedValue [ --help ]"
