#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="type.sh"
description="Is a variable declared as an array?"$'\n'"Argument: variableName - String. Required. Variable name to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/type.sh"
foundNames=()
rawComment="Is a variable declared as an array?"$'\n'"Argument: variableName - String. Required. Variable name to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Is a variable declared as an array?"
usage="isArray"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misArray'$'\e''[0m'$'\n'''$'\n''Is a variable declared as an array?'$'\n''Argument: variableName - String. Required. Variable name to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isArray'$'\n'''$'\n''Is a variable declared as an array?'$'\n''Argument: variableName - String. Required. Variable name to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.434
