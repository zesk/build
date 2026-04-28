#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-28
# shellcheck disable=SC2034
argument="variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Validates zero or more environment variable names."$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'"First letter MUST NOT be a digit"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentVariableNameValid"
foundNames=([0]="argument")
line="16"
lowerFn="environmentvariablenamevalid"
rawComment="Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Validates zero or more environment variable names."$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'"First letter MUST NOT be a digit"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="35cdca77b3e2eb9cbbffdcfb5879a32efdbd22a7"
sourceLine="16"
summary="Validates zero or more environment variable names."
summaryComputed="true"
usage="environmentVariableNameValid variableName ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentVariableNameValid'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvariableName ...  '$'\e''[[(value)]mString. Required. Exit status 0 if all variables names are valid ones.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Validates zero or more environment variable names.'$'\n''- alpha'$'\n''- digit'$'\n''- underscore'$'\n''First letter MUST NOT be a digit'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentVariableNameValid variableName ... [ --help ]'$'\n'''$'\n''    variableName ...  String. Required. Exit status 0 if all variables names are valid ones.'$'\n''    --help            Flag. Optional. Display this help.'$'\n'''$'\n''Validates zero or more environment variable names.'$'\n''- alpha'$'\n''- digit'$'\n''- underscore'$'\n''First letter MUST NOT be a digit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/environment.md"
