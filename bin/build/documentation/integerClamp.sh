#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
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
line="652"
original="integerClamp"
rawComment=$'Clamp digits between two integers\nReads stdin digits, one per line, and outputs only integer values between $min and $max\nArgument: minimum - Integer|Empty. Minimum integer value to output.\nArgument: maximum - Integer|Empty. Maximum integer value to output.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="480be5db852b12675144ab1e6476bc78bcb875fa"
sourceLine="652"
summary="Clamp digits between two integers"
summaryComputed="true"
usage="integerClamp [ minimum ] [ maximum ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mintegerClamp'$'\e''[0m '$'\e''[[(blue)]m[ minimum ]'$'\e''[0m '$'\e''[[(blue)]m[ maximum ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mminimum  '$'\e''[[(value)]mInteger|Empty. Minimum integer value to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmaximum  '$'\e''[[(value)]mInteger|Empty. Maximum integer value to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Clamp digits between two integers'$'\n''Reads stdin digits, one per line, and outputs only integer values between $min and $max'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: integerClamp [ minimum ] [ maximum ] [ --help ]'$'\n'''$'\n''    minimum  Integer|Empty. Minimum integer value to output.'$'\n''    maximum  Integer|Empty. Maximum integer value to output.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Clamp digits between two integers'$'\n''Reads stdin digits, one per line, and outputs only integer values between $min and $max'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/text.md"
