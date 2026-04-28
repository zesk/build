#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-28
# shellcheck disable=SC2034
argument="file - File to get the owner for"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Get the file owner name"$'\n'"Outputs the file owner for each file passed on the command line"$'\n'""
file="bin/build/tools/file.sh"
fn="fileOwner"
foundNames=([0]="argument" [1]="return_code")
line="508"
lowerFn="fileowner"
rawComment="Get the file owner name"$'\n'"Argument: file - File to get the owner for"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs the file owner for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Unable to access file"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="508"
summary="Get the file owner name"
summaryComputed="true"
usage="fileOwner [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileOwner'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile to get the owner for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the file owner name'$'\n''Outputs the file owner for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Unable to access file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileOwner [ file ] [ --help ]'$'\n'''$'\n''    file    File to get the owner for'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the file owner name'$'\n''Outputs the file owner for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Unable to access file'$'\n'''
documentationPath="documentation/source/tools/file.md"
