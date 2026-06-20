#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List types which can be validated.\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="validateTypeList"
fnMarker="validatetypelist"
foundNames=([0]="stdout" [1]="argument" [2]="summary")
line="506"
original="validateTypeList"
rawComment=$'List types which can be validated.\nstdout: Type\nArgument: --help - Flag. Optional. Display this help.\nSummary: Types which can be validated\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="5f89904415ec5aff0f26d85665396d1091b18d0c"
sourceLine="506"
stdout=$'Type\n'
summary="Types which can be validated"
summaryComputed=""
usage="validateTypeList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mvalidateTypeList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List types which can be validated.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Type'
# shellcheck disable=SC2016
helpPlain='Usage: validateTypeList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List types which can be validated.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Type'
documentationPath="documentation/source/tools/validate.md"
