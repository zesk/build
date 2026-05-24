#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'file - File. Optional. One or more files, all of which must be empty.\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is this an empty (zero-sized) file?\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileIsEmpty"
fnMarker="fileisempty"
foundNames=([0]="return_code" [1]="argument")
line="632"
rawComment=$'Is this an empty (zero-sized) file?\nReturn Code: 0 - if all files passed in are empty files\nReturn Code: 1 - if any files passed in are non-empty files\nArgument: file - File. Optional. One or more files, all of which must be empty.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - if all files passed in are empty files\n1 - if any files passed in are non-empty files\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="632"
summary="Is this an empty (zero-sized) file?"
summaryComputed="true"
usage="fileIsEmpty [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileIsEmpty'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile. Optional. One or more files, all of which must be empty.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is this an empty (zero-sized) file?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if all files passed in are empty files'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if any files passed in are non-empty files'
# shellcheck disable=SC2016
helpPlain='Usage: fileIsEmpty [ file ] [ --help ]'$'\n'''$'\n''    file    File. Optional. One or more files, all of which must be empty.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is this an empty (zero-sized) file?'$'\n'''$'\n''Return codes:'$'\n''- 0 - if all files passed in are empty files'$'\n''- 1 - if any files passed in are non-empty files'
documentationPath="documentation/source/tools/file.md"
