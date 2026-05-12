#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ntype - String. Optional. Type to validate as `validate` type.\n'
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Are all arguments passed a valid validate type?\n\n'
descriptionLineCount="2"
example=$'    isValidateType string || returnMessage 1 "string is not a type."\n'
file="bin/build/tools/validate.sh"
fn="isValidateType"
fnMarker="isvalidatetype"
foundNames=([0]="argument" [1]="example")
line="459"
rawComment=$'Are all arguments passed a valid validate type?\nArgument: --help - Flag. Optional. Display this help.\nArgument: type - String. Optional. Type to validate as `validate` type.\nExample:     isValidateType string || returnMessage 1 "string is not a type."\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="8595bd205075ea66502917fa8a6527b03c479b28"
sourceLine="459"
summary="Are all arguments passed a valid validate type?"
summaryComputed="true"
usage="isValidateType [ --help ] [ type ]"
