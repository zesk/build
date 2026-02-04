#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
description="List lines of environment values set in a bash state file"$'\n'""
example="    environmentLines < \"\$stateFile\""$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=([0]="example" [1]="argument")
rawComment="Example:     {fn} < \"\$stateFile\""$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"List lines of environment values set in a bash state file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="ab40396c0bbaf04b90ac18495770691379efbd1a"
summary="List lines of environment values set in a bash state"
summaryComputed="true"
usage="environmentLines [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentLines'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List lines of environment values set in a bash state file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    environmentLines < "$stateFile"'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]menvironmentLines [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''List lines of environment values set in a bash state file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    environmentLines < "$stateFile"'$'\n'''
