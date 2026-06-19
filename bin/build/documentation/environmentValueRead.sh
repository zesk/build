#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'stateFile - EnvironmentFile. Required. File to read a value from.\nname - EnvironmentVariable. Required. Variable to read.\ndefault - EmptyString. Optional. Default value of the environment variable if it does not exist.\n--help - Flag. Optional. Display this help.\n'
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'No documentation for `environmentValueRead`.\n'
descriptionLineCount=""
file="bin/build/tools/environment/io.sh"
fn="environmentValueRead"
fnMarker="environmentvalueread"
foundNames=([0]="argument" [1]="return_code")
line="89"
rawComment=$'Argument: stateFile - EnvironmentFile. Required. File to read a value from.\nArgument: name - EnvironmentVariable. Required. Variable to read.\nArgument: default - EmptyString. Optional. Default value of the environment variable if it does not exist.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 1 - If value is not found and no default argument is supplied (2 arguments)\nReturn Code: 0 - If value\n\n'
return_code=$'1 - If value is not found and no default argument is supplied (2 arguments)\n0 - If value\n'
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="565ea7df1e58c04e83b459faee071a3b938bd9d4"
sourceLine="89"
summary="undocumented"
summaryComputed=""
usage="environmentValueRead stateFile name [ default ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueRead'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstateFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ default ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstateFile  '$'\e''[[(value)]mEnvironmentFile. Required. File to read a value from.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mname       '$'\e''[[(value)]mEnvironmentVariable. Required. Variable to read.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdefault    '$'\e''[[(value)]mEmptyString. Optional. Default value of the environment variable if it does not exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]menvironmentValueRead'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If value is not found and no default argument is supplied (2 arguments)'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If value'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueRead stateFile name [ default ] [ --help ]'$'\n'''$'\n''    stateFile  EnvironmentFile. Required. File to read a value from.'$'\n''    name       EnvironmentVariable. Required. Variable to read.'$'\n''    default    EmptyString. Optional. Default value of the environment variable if it does not exist.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''No documentation for environmentValueRead.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If value is not found and no default argument is supplied (2 arguments)'$'\n''- 0 - If value'
documentationPath="documentation/source/tools/environment.md"
