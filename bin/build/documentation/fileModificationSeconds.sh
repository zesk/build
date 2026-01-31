#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'"Argument: filename ... - File to fetch modification time"$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'"Example:     fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'"Argument: filename ... - File to fetch modification time"$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'"Example:     fileModificationTime ~/.bash_profile"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Fetch the modification time in seconds from now of a"
usage="fileModificationSeconds"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationSeconds'$'\e''[0m'$'\n'''$'\n''Fetch the modification time in seconds from now of a file as a timestamp'$'\n''Argument: filename ... - File to fetch modification time'$'\n''Return Code: 2 - If file does not exist'$'\n''Return Code: 0 - If file exists and modification times are output, one per line'$'\n''Example:     fileModificationTime ~/.bash_profile'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationSeconds'$'\n'''$'\n''Fetch the modification time in seconds from now of a file as a timestamp'$'\n''Argument: filename ... - File to fetch modification time'$'\n''Return Code: 2 - If file does not exist'$'\n''Return Code: 0 - If file exists and modification times are output, one per line'$'\n''Example:     fileModificationTime ~/.bash_profile'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.515
