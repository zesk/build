#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-14
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"file - File. Optional. File(s) to list bash functions defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="List functions in a given shell file"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="List functions in a given shell file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: file - File. Optional. File(s) to list bash functions defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: __bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""$'\n'""
requires="__bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="e66246980f40066fe4c09e2727ffc628f6b42f38"
summary="List functions in a given shell file"
summaryComputed="true"
usage="bashListFunctions [ --help ] [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashListFunctions'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile. Optional. File(s) to list bash functions defined within.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List functions in a given shell file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashListFunctions [ --help ] [ file ] [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    file    File. Optional. File(s) to list bash functions defined within.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List functions in a given shell file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
