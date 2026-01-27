#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/io.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
description="List names of environment values set in a bash state file"$'\n'""
example="    environmentNames < \"\$stateFile\""$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=([0]="example" [1]="argument")
rawComment="Example:     {fn} < \"\$stateFile\""$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"List names of environment values set in a bash state file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceModified="1769451204"
summary="List names of environment values set in a bash state"
usage="environmentNames [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentNames'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List names of environment values set in a bash state file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    environmentNames < "$stateFile"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentNames [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List names of environment values set in a bash state file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    environmentNames < "$stateFile"'$'\n'''
# elapsed 0.45
