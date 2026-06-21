#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'unsigned integer is greater than or equal to zero\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeUnsignedInteger"
fnMarker="__validatetypeunsignedinteger"
foundNames=()
line="251"
original="__validateTypeUnsignedInteger"
rawComment=$'unsigned integer is greater than or equal to zero\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="6aa8ba7c4c01e78e1aaa60bba330293420ad5579"
sourceLine="251"
summary="unsigned integer is greater than or equal to zero"
summaryComputed="true"
usage="__validateTypeUnsignedInteger"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeUnsignedInteger'$'\e''[0m'$'\n'''$'\n''unsigned integer is greater than or equal to zero'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeUnsignedInteger'$'\n'''$'\n''unsigned integer is greater than or equal to zero'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
