#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'file ... - File. Required. One or more files to examine\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Prints seconds since modified\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileModifiedSeconds"
fnMarker="filemodifiedseconds"
foundNames=([0]="argument" [1]="return_code")
line="256"
rawComment=$'Prints seconds since modified\nArgument: file ... - File. Required. One or more files to examine\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Success\nReturn Code: 2 - Can not get modification time\n\n'
return_code=$'0 - Success\n2 - Can not get modification time\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="256"
summary="Prints seconds since modified"
summaryComputed="true"
usage="fileModifiedSeconds file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedSeconds'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to examine'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints seconds since modified'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Can not get modification time'
# shellcheck disable=SC2016
helpPlain='Usage: fileModifiedSeconds file ... [ --help ]'$'\n'''$'\n''    file ...  File. Required. One or more files to examine'$'\n''    --help    Flag. Optional. Display this help.'$'\n'''$'\n''Prints seconds since modified'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Can not get modification time'
documentationPath="documentation/source/tools/file.md"
