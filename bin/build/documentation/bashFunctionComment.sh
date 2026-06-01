#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashFunctionComment"
fnMarker="bashfunctioncomment"
foundNames=([0]="argument" [1]="requires")
line="619"
rawComment="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: grep cut fileReverseLines helpArgument"$'\n'"Requires: bashDocumentation"$'\n'""$'\n'""
requires="grep cut fileReverseLines helpArgument"$'\n'"bashDocumentation"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="aacd731aa1df64fbee5b48bdf1d0f86bc8ed4f3e"
sourceLine="619"
summary="Extract a bash comment from a file. Excludes lines containing"
summaryComputed="true"
usage="bashFunctionComment source functionName [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionComment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource        '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionComment source functionName [ --help ]'$'\n'''$'\n''    source        File. Required. File where the function is defined.'$'\n''    functionName  String. Required. The name of the bash function to extract the documentation for.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
