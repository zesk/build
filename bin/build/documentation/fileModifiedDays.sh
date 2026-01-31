#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Prints days (integer) since modified"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Prints days (integer) since modified"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Prints days (integer) since modified"
usage="fileModifiedDays"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedDays'$'\e''[0m'$'\n'''$'\n''Prints days (integer) since modified'$'\n''Argument: file ... - File. Required. One or more files to examine'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Success'$'\n''Return Code: 2 - Can not get modification time'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileModifiedDays'$'\n'''$'\n''Prints days (integer) since modified'$'\n''Argument: file ... - File. Required. One or more files to examine'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Success'$'\n''Return Code: 2 - Can not get modification time'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
