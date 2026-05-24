#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'minimum - Integer|Empty. Minimum integer value to output.\nmaximum - Integer|Empty. Maximum integer value to output.\n--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Clamp digits between two integers\nReads stdin digits, one per line, and outputs only integer values between $min and $max\n\n'
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="integerClamp"
fnMarker="integerclamp"
foundNames=([0]="argument")
line="596"
rawComment=$'Clamp digits between two integers\nReads stdin digits, one per line, and outputs only integer values between $min and $max\nArgument: minimum - Integer|Empty. Minimum integer value to output.\nArgument: maximum - Integer|Empty. Maximum integer value to output.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="596"
summary="Clamp digits between two integers"
summaryComputed="true"
usage="integerClamp [ minimum ] [ maximum ] [ --help ]"
