#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: grep cut fileReverseLines __help"$'\n'"Requires: usageDocument"$'\n'""$'\n'""
requires="grep cut fileReverseLines __help"$'\n'"usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Extract a bash comment from a file. Excludes lines containing"
summaryComputed="true"
usage="bashFunctionComment source functionName [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionComment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource        '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbashFunctionComment [[(magenta)]msource [[(magenta)]mfunctionName [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(red)]msource        [[(value)]mFile. Required. File where the function is defined.'$'\n''    [[(red)]mfunctionName  [[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\n''    [[(blue)]m--help        [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 4.117
