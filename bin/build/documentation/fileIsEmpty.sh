#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Is this an empty (zero-sized) file?"$'\n'"Return Code: 0 - if all files passed in are empty files"$'\n'"Return Code: 1 - if any files passed in are non-empty files"$'\n'"Argument: file - File. Optional. One or more files, all of which must be empty."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Is this an empty (zero-sized) file?"$'\n'"Return Code: 0 - if all files passed in are empty files"$'\n'"Return Code: 1 - if any files passed in are non-empty files"$'\n'"Argument: file - File. Optional. One or more files, all of which must be empty."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Is this an empty (zero-sized) file?"
usage="fileIsEmpty"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileIsEmpty'$'\e''[0m'$'\n'''$'\n''Is this an empty (zero-sized) file?'$'\n''Return Code: 0 - if all files passed in are empty files'$'\n''Return Code: 1 - if any files passed in are non-empty files'$'\n''Argument: file - File. Optional. One or more files, all of which must be empty.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileIsEmpty'$'\n'''$'\n''Is this an empty (zero-sized) file?'$'\n''Return Code: 0 - if all files passed in are empty files'$'\n''Return Code: 1 - if any files passed in are non-empty files'$'\n''Argument: file - File. Optional. One or more files, all of which must be empty.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.513
