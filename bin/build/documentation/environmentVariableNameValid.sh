#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="environment.sh"
description="Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Validates zero or more environment variable names."$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'"First letter MUST NOT be a digit"$'\n'""
file="bin/build/tools/environment.sh"
foundNames=()
rawComment="Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Validates zero or more environment variable names."$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'"First letter MUST NOT be a digit"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="4226efba8a29858c837cfce31f7416e4226eaa32"
summary="Argument: variableName ... - String. Required. Exit status 0 if"
usage="environmentVariableNameValid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentVariableNameValid'$'\e''[0m'$'\n'''$'\n''Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Validates zero or more environment variable names.'$'\n''- alpha'$'\n''- digit'$'\n''- underscore'$'\n''First letter MUST NOT be a digit'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentVariableNameValid'$'\n'''$'\n''Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Validates zero or more environment variable names.'$'\n''- alpha'$'\n''- digit'$'\n''- underscore'$'\n''First letter MUST NOT be a digit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.463
