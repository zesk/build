#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="filename ... - File to fetch modification time"$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'""$'\n'""
descriptionLineCount="2"
example="    fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationSeconds"
fnMarker="filemodificationseconds"
foundNames=([0]="argument" [1]="return_code" [2]="example")
line="84"
rawComment="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'"Argument: filename ... - File to fetch modification time"$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'"Example:     fileModificationTime ~/.bash_profile"$'\n'""$'\n'""
return_code="2 - If file does not exist"$'\n'"0 - If file exists and modification times are output, one per line"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="84"
summary="Fetch the modification time in seconds from now of a"
summaryComputed="true"
usage="fileModificationSeconds [ filename ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationSeconds'$'\e''[0m '$'\e''[[(blue)]m[ filename ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename ...  '$'\e''[[(value)]mFile to fetch modification time'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch the modification time in seconds from now of a file as a timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - If file does not exist'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If file exists and modification times are output, one per line'$'\n'''$'\n''Example:'$'\n''    fileModificationTime ~/.bash_profile'
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationSeconds [ filename ... ]'$'\n'''$'\n''    filename ...  File to fetch modification time'$'\n'''$'\n''Fetch the modification time in seconds from now of a file as a timestamp'$'\n'''$'\n''Return codes:'$'\n''- 2 - If file does not exist'$'\n''- 0 - If file exists and modification times are output, one per line'$'\n'''$'\n''Example:'$'\n''    fileModificationTime ~/.bash_profile'
documentationPath="documentation/source/tools/file.md"
