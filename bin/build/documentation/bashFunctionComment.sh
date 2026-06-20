#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'source - File. Required. File where the function is defined.\nfunctionName - String. Required. The name of the bash function to extract the documentation for.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs a function comment in a file.\nExcludes lines similarly to `bashFirstComment`.\n\n'
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashFunctionComment"
fnMarker="bashfunctioncomment"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="requires")
line="631"
original="bashFunctionComment"
rawComment=$'Summary: Output the comment for a function in a file\nOutputs a function comment in a file.\nExcludes lines similarly to `bashFirstComment`.\nSee: bashFirstComment\nArgument: source - File. Required. File where the function is defined.\nArgument: functionName - String. Required. The name of the bash function to extract the documentation for.\nArgument: --help - Flag. Optional. Display this help.\nRequires: grep cut fileReverseLines helpArgument\nRequires: bashDocumentation\n\n'
requires=$'grep cut fileReverseLines helpArgument\nbashDocumentation\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'bashFirstComment\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9822477a1f3a6f53599f6f26b9aa3886ba4c5595"
sourceLine="631"
summary="Output the comment for a function in a file"
summaryComputed=""
usage="bashFunctionComment source functionName [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionComment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource        '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs a function comment in a file.'$'\n''Excludes lines similarly to '$'\e''[[(code)]mbashFirstComment'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionComment source functionName [ --help ]'$'\n'''$'\n''    source        File. Required. File where the function is defined.'$'\n''    functionName  String. Required. The name of the bash function to extract the documentation for.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Outputs a function comment in a file.'$'\n''Excludes lines similarly to bashFirstComment.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
