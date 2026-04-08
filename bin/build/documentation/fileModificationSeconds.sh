#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="filename ... - File to fetch modification time"$'\n'""
base="file.sh"
description="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'""
example="    fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationSeconds"
foundNames=([0]="argument" [1]="return_code" [2]="example")
rawComment="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'"Argument: filename ... - File to fetch modification time"$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'"Example:     fileModificationTime ~/.bash_profile"$'\n'""$'\n'""
return_code="2 - If file does not exist"$'\n'"0 - If file exists and modification times are output, one per line"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="7a68c870255c297437371bfaf0f2d87b4eae10f2"
summary="Fetch the modification time in seconds from now of a"
summaryComputed="true"
usage="fileModificationSeconds [ filename ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationSeconds'$'\e''[0m '$'\e''[[(blue)]m[ filename ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename ...  '$'\e''[[(value)]mFile to fetch modification time'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch the modification time in seconds from now of a file as a timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - If file does not exist'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If file exists and modification times are output, one per line'$'\n'''$'\n''Example:'$'\n''    fileModificationTime ~/.bash_profile'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationSeconds [ filename ... ]'$'\n'''$'\n''    filename ...  File to fetch modification time'$'\n'''$'\n''Fetch the modification time in seconds from now of a file as a timestamp'$'\n'''$'\n''Return codes:'$'\n''- 2 - If file does not exist'$'\n''- 0 - If file exists and modification times are output, one per line'$'\n'''$'\n''Example:'$'\n''    fileModificationTime ~/.bash_profile'$'\n'''
