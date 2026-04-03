#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="file - File. Optional. One or more files, all of which must be empty."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Is this an empty (zero-sized) file?"$'\n'""
file="bin/build/tools/file.sh"
fn="fileIsEmpty"
foundNames=([0]="return_code" [1]="argument")
rawComment="Is this an empty (zero-sized) file?"$'\n'"Return Code: 0 - if all files passed in are empty files"$'\n'"Return Code: 1 - if any files passed in are non-empty files"$'\n'"Argument: file - File. Optional. One or more files, all of which must be empty."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - if all files passed in are empty files"$'\n'"1 - if any files passed in are non-empty files"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="738fcd1771dc6ce03a870787b6db46f942c7ff09"
summary="Is this an empty (zero-sized) file?"
summaryComputed="true"
usage="fileIsEmpty [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileIsEmpty'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile. Optional. One or more files, all of which must be empty.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is this an empty (zero-sized) file?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if all files passed in are empty files'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if any files passed in are non-empty files'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileIsEmpty [ file ] [ --help ]'$'\n'''$'\n''    file    File. Optional. One or more files, all of which must be empty.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is this an empty (zero-sized) file?'$'\n'''$'\n''Return codes:'$'\n''- 0 - if all files passed in are empty files'$'\n''- 1 - if any files passed in are non-empty files'$'\n'''
