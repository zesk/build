#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to examine"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Prints seconds since modified"$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Prints seconds since modified"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Can not get modification time"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Prints seconds since modified"
summaryComputed="true"
usage="fileModifiedSeconds file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedSeconds'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to examine'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints seconds since modified'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Can not get modification time'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mfileModifiedSeconds [[(bold)]m[[(magenta)]mfile ... [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(red)]mfile ...  [[(value)]mFile. Required. One or more files to examine[[(reset)]m'$'\n''    [[(blue)]m--help    [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n'''$'\n''Prints seconds since modified'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m2[[(reset)]m - Can not get modification time'$'\n'''
# elapsed 3.538
