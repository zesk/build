#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to examine"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Prints seconds since modified"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModifiedSeconds"
foundNames=([0]="argument" [1]="return_code")
line="256"
lowerFn="filemodifiedseconds"
rawComment="Prints seconds since modified"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Can not get modification time"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="7a68c870255c297437371bfaf0f2d87b4eae10f2"
sourceLine="256"
summary="Prints seconds since modified"
summaryComputed="true"
usage="fileModifiedSeconds file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedSeconds'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to examine'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints seconds since modified'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Can not get modification time'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileModifiedSeconds file ... [ --help ]'$'\n'''$'\n''    file ...  File. Required. One or more files to examine'$'\n''    --help    Flag. Optional. Display this help.'$'\n'''$'\n''Prints seconds since modified'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Can not get modification time'$'\n'''
documentationPath="documentation/source/tools/file.md"
