#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: grep cut fileReverseLines __help"$'\n'"Requires: usageDocument"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: grep cut fileReverseLines __help"$'\n'"Requires: usageDocument"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Extract a bash comment from a file. Excludes lines containing"
usage="bashFunctionComment"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionComment'$'\e''[0m'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n''Argument: source - File. Required. File where the function is defined.'$'\n''Argument: functionName - String. Required. The name of the bash function to extract the documentation for.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Requires: grep cut fileReverseLines __help'$'\n''Requires: usageDocument'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionComment'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n''Argument: source - File. Required. File where the function is defined.'$'\n''Argument: functionName - String. Required. The name of the bash function to extract the documentation for.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Requires: grep cut fileReverseLines __help'$'\n''Requires: usageDocument'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.482
