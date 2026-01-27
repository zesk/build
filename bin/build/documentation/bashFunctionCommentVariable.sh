#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"variableName - string. Required. Get this variable value"$'\n'"--prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="argument")
rawComment="Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: variableName - string. Required. Get this variable value"$'\n'"Argument: --prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Gets a list of the variable values from a bash function comment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769535118"
summary="Gets a list of the variable values from a bash"
usage="bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionCommentVariable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource        '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mvariableName  '$'\e''[[(value)]mstring. Required. Get this variable value'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix      '$'\e''[[(value)]mflag. Optional. Find variables with the prefix '$'\e''[[(code)]mvariableName'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --help ]'$'\n'''$'\n''    source        File. Required. File where the function is defined.'$'\n''    functionName  String. Required. The name of the bash function to extract the documentation for.'$'\n''    variableName  string. Required. Get this variable value'$'\n''    --prefix      flag. Optional. Find variables with the prefix variableName'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.486
