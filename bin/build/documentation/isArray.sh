#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="variableName - String. Required. Variable name to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
description="Is a variable declared as an array?"$'\n'""
file="bin/build/tools/type.sh"
fn="isArray"
foundNames=([0]="argument")
line="126"
lowerFn="isarray"
rawComment="Is a variable declared as an array?"$'\n'"Argument: variableName - String. Required. Variable name to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="126"
summary="Is a variable declared as an array?"
summaryComputed="true"
usage="isArray variableName [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misArray'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvariableName  '$'\e''[[(value)]mString. Required. Variable name to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is a variable declared as an array?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isArray variableName [ --help ]'$'\n'''$'\n''    variableName  String. Required. Variable name to check.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Is a variable declared as an array?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/type.md"
