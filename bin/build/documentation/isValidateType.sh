#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"type - String. Optional. Type to validate as \`validate\` type."$'\n'""
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are all arguments passed a valid validate type?"$'\n'""$'\n'""
descriptionLineCount="2"
example="    isValidateType string || returnMessage 1 \"string is not a type.\""$'\n'""
file="bin/build/tools/validate.sh"
fn="isValidateType"
fnMarker="isvalidatetype"
foundNames=([0]="argument" [1]="example")
line="460"
rawComment="Are all arguments passed a valid validate type?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: type - String. Optional. Type to validate as \`validate\` type."$'\n'"Example:     isValidateType string || returnMessage 1 \"string is not a type.\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/validate.sh"
sourceHash="522e9f56d46559913d7d8b5cc588ce27cb0e06e9"
sourceLine="460"
summary="Are all arguments passed a valid validate type?"
summaryComputed="true"
usage="isValidateType [ --help ] [ type ]"
