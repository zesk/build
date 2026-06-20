#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'functionName - String. Required. Name of function to check.\nfile ... - File. Required. One or more files to check if a function is defined within.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a function defined in a bash source file?"
descriptionLineCount=""
file="bin/build/tools/bash.sh"
fn="bashFunctionDefined"
fnMarker="bashfunctiondefined"
foundNames=([0]="summary" [1]="argument")
line="258"
original="bashFunctionDefined"
rawComment=$'Summary: Is a function defined in a bash source file?\nArgument: functionName - String. Required. Name of function to check.\nArgument: file ... - File. Required. One or more files to check if a function is defined within.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9822477a1f3a6f53599f6f26b9aa3886ba4c5595"
sourceLine="258"
summary="Is a function defined in a bash source file?"
summaryComputed=""
usage="bashFunctionDefined functionName file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionDefined'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. Name of function to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile ...      '$'\e''[[(value)]mFile. Required. One or more files to check if a function is defined within.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is a function defined in a bash source file?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionDefined functionName file ... [ --help ]'$'\n'''$'\n''    functionName  String. Required. Name of function to check.'$'\n''    file ...      File. Required. One or more files to check if a function is defined within.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Is a function defined in a bash source file?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
