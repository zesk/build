#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to examine"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Output the newest file in the list"$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument")
rawComment="Output the newest file in the list"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Output the newest file in the list"
usage="fileNewest file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileNewest'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to examine'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the newest file in the list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileNewest file ... [ --help ]'$'\n'''$'\n''    file ...  File. Required. One or more files to examine'$'\n''    --help    Flag. Optional. Display this help.'$'\n'''$'\n''Output the newest file in the list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.694
