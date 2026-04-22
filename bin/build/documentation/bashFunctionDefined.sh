#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="functionName - String. Required. Name of function to check."$'\n'"file ... - File. Required. One or more files to check if a function is defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Is a function defined in a bash source file?"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionDefined"
foundNames=([0]="summary" [1]="argument")
line="257"
lowerFn="bashfunctiondefined"
rawComment="Summary: Is a function defined in a bash source file?"$'\n'"Argument: functionName - String. Required. Name of function to check."$'\n'"Argument: file ... - File. Required. One or more files to check if a function is defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="ce103c0a855c85ae7ea74c3b00899b56536cfe79"
sourceLine="257"
summary="Is a function defined in a bash source file?"$'\n'""
usage="bashFunctionDefined functionName file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionDefined'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. Name of function to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile ...      '$'\e''[[(value)]mFile. Required. One or more files to check if a function is defined within.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is a function defined in a bash source file?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionDefined functionName file ... [ --help ]'$'\n'''$'\n''    functionName  String. Required. Name of function to check.'$'\n''    file ...      File. Required. One or more files to check if a function is defined within.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Is a function defined in a bash source file?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/bash.md"
