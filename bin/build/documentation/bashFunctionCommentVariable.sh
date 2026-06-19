#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'source - File. Required. File where the function is defined.\nfunctionName - String. Required. The name of the bash function to extract the documentation for.\nvariableName - string. Required. Get this variable value\n--prefix - flag. Optional. Find variables with the prefix `variableName`\n--i | --insensitive - Flag. Optional. Case-insensitive match.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Gets a list of the variable values from a bash function comment\n\n'
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashFunctionCommentVariable"
fnMarker="bashfunctioncommentvariable"
foundNames=([0]="argument")
line="410"
rawComment=$'Argument: source - File. Required. File where the function is defined.\nArgument: functionName - String. Required. The name of the bash function to extract the documentation for.\nArgument: variableName - string. Required. Get this variable value\nArgument: --prefix - flag. Optional. Find variables with the prefix `variableName`\nArgument: --i | --insensitive - Flag. Optional. Case-insensitive match.\nArgument: --help - Flag. Optional. Display this help.\nGets a list of the variable values from a bash function comment\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="44e2d7bb2f580d31f81f1caec019ec7815f1d160"
sourceLine="410"
summary="Gets a list of the variable values from a bash"
summaryComputed="true"
usage="bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --i | --insensitive ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionCommentVariable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --i | --insensitive ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource               '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName         '$'\e''[[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mvariableName         '$'\e''[[(value)]mstring. Required. Get this variable value'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix             '$'\e''[[(value)]mflag. Optional. Find variables with the prefix '$'\e''[[(code)]mvariableName'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--i | --insensitive  '$'\e''[[(value)]mFlag. Optional. Case-insensitive match.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --i | --insensitive ] [ --help ]'$'\n'''$'\n''    source               File. Required. File where the function is defined.'$'\n''    functionName         String. Required. The name of the bash function to extract the documentation for.'$'\n''    variableName         string. Required. Get this variable value'$'\n''    --prefix             flag. Optional. Find variables with the prefix variableName'$'\n''    --i | --insensitive  Flag. Optional. Case-insensitive match.'$'\n''    --help               Flag. Optional. Display this help.'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
