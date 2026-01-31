#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="file - File to get the owner for"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Get the file owner name"$'\n'"Outputs the file owner for each file passed on the command line"$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Get the file owner name"$'\n'"Argument: file - File to get the owner for"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs the file owner for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Unable to access file"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Get the file owner name"
summaryComputed="true"
usage="fileOwner [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileOwner'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile to get the owner for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the file owner name'$'\n''Outputs the file owner for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Unable to access file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileOwner [ file ] [ --help ]'$'\n'''$'\n''    file    File to get the owner for'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the file owner name'$'\n''Outputs the file owner for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Unable to access file'$'\n'''
# elapsed 3.345
