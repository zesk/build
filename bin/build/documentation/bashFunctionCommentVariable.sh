#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"variableName - string. Required. Get this variable value"$'\n'"--prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--i | --insensitive - Flag. Optional. Case-insensitive match."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionCommentVariable"
foundNames=([0]="argument")
line="407"
lowerFn="bashfunctioncommentvariable"
rawComment="Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: variableName - string. Required. Get this variable value"$'\n'"Argument: --prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --i | --insensitive - Flag. Optional. Case-insensitive match."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Gets a list of the variable values from a bash function comment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="286d8187414ff4bf8505a905b49ba4ca2b627ae9"
sourceLine="407"
summary="Gets a list of the variable values from a bash"
summaryComputed="true"
usage="bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --i | --insensitive ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionCommentVariable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --i | --insensitive ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource               '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName         '$'\e''[[(value)]mString. Required. The name of the bash function to extract the documentation for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mvariableName         '$'\e''[[(value)]mstring. Required. Get this variable value'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix             '$'\e''[[(value)]mflag. Optional. Find variables with the prefix '$'\e''[[(code)]mvariableName'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--i | --insensitive  '$'\e''[[(value)]mFlag. Optional. Case-insensitive match.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --i | --insensitive ] [ --help ]'$'\n'''$'\n''    source               File. Required. File where the function is defined.'$'\n''    functionName         String. Required. The name of the bash function to extract the documentation for.'$'\n''    variableName         string. Required. Get this variable value'$'\n''    --prefix             flag. Optional. Find variables with the prefix variableName'$'\n''    --i | --insensitive  Flag. Optional. Case-insensitive match.'$'\n''    --help               Flag. Optional. Display this help.'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/bash.md"
