#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-09
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to examine"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Prints days (integer) since modified"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModifiedDays"
foundNames=([0]="argument" [1]="return_code")
rawComment="Prints days (integer) since modified"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Can not get modification time"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="91d537b691b9a05e675b0b8e8fc9b5d80f144523"
summary="Prints days (integer) since modified"
summaryComputed="true"
usage="fileModifiedDays file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='➡️ "__usageDocumentCached" "_usageDocument" "/Users/kent/marketacumen/build" "fileModifiedDays" "0"'$'\n'''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedDays'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to examine'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints days (integer) since modified'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Can not get modification time'$'\n'''
# shellcheck disable=SC2016
helpPlain='➡️ "__usageDocumentCached" "_usageDocument" "/Users/kent/marketacumen/build" "fileModifiedDays" "0"'$'\n''Usage: fileModifiedDays file ... [ --help ]'$'\n'''$'\n''    file ...  File. Required. One or more files to examine'$'\n''    --help    Flag. Optional. Display this help.'$'\n'''$'\n''Prints days (integer) since modified'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Can not get modification time'$'\n'''
