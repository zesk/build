#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: variableName - string. Required. Get this variable value"$'\n'"Argument: --prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: variableName - string. Required. Get this variable value"$'\n'"Argument: --prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Gets a list of the variable values from a bash function comment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Argument: source - File. Required. File where the function is"
usage="bashFunctionCommentVariable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionCommentVariable'$'\e''[0m'$'\n'''$'\n''Argument: source - File. Required. File where the function is defined.'$'\n''Argument: functionName - String. Required. The name of the bash function to extract the documentation for.'$'\n''Argument: variableName - string. Required. Get this variable value'$'\n''Argument: --prefix - flag. Optional. Find variables with the prefix '$'\e''[[(code)]mvariableName'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionCommentVariable'$'\n'''$'\n''Argument: source - File. Required. File where the function is defined.'$'\n''Argument: functionName - String. Required. The name of the bash function to extract the documentation for.'$'\n''Argument: variableName - string. Required. Get this variable value'$'\n''Argument: --prefix - flag. Optional. Find variables with the prefix variableName'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.49
