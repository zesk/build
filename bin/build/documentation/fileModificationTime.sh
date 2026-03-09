#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-09
# shellcheck disable=SC2034
argument="filename ... - File to fetch modification time"$'\n'""
base="file.sh"
description="Fetch the modification time of a file as a timestamp"$'\n'""
example="    fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationTime"
foundNames=([0]="argument" [1]="return_code" [2]="example")
rawComment="Fetch the modification time of a file as a timestamp"$'\n'"Argument: filename ... - File to fetch modification time"$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'"Example:     fileModificationTime ~/.bash_profile"$'\n'""$'\n'""
return_code="2 - If file does not exist"$'\n'"0 - If file exists and modification times are output, one per line"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="91d537b691b9a05e675b0b8e8fc9b5d80f144523"
summary="Fetch the modification time of a file as a timestamp"
summaryComputed="true"
usage="fileModificationTime [ filename ... ]"
# shellcheck disable=SC2016
helpConsole='➡️ "__usageDocumentCached" "_usageDocument" "/Users/kent/marketacumen/build" "fileModificationTime" "0"'$'\n'''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationTime'$'\e''[0m '$'\e''[[(blue)]m[ filename ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename ...  '$'\e''[[(value)]mFile to fetch modification time'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch the modification time of a file as a timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - If file does not exist'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If file exists and modification times are output, one per line'$'\n'''$'\n''Example:'$'\n''    fileModificationTime ~/.bash_profile'$'\n'''
# shellcheck disable=SC2016
helpPlain='➡️ "__usageDocumentCached" "_usageDocument" "/Users/kent/marketacumen/build" "fileModificationTime" "0"'$'\n''Usage: fileModificationTime [ filename ... ]'$'\n'''$'\n''    filename ...  File to fetch modification time'$'\n'''$'\n''Fetch the modification time of a file as a timestamp'$'\n'''$'\n''Return codes:'$'\n''- 2 - If file does not exist'$'\n''- 0 - If file exists and modification times are output, one per line'$'\n'''$'\n''Example:'$'\n''    fileModificationTime ~/.bash_profile'$'\n'''
