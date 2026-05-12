#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List types which can be validated\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="validateTypeList"
fnMarker="validatetypelist"
foundNames=()
line="443"
rawComment=$'List types which can be validated\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="8595bd205075ea66502917fa8a6527b03c479b28"
sourceLine="443"
summary="List types which can be validated"
summaryComputed="true"
usage="validateTypeList"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mvalidateTypeList'$'\e''[0m'$'\n'''$'\n''List types which can be validated'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: validateTypeList'$'\n'''$'\n''List types which can be validated'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/validate.md"
