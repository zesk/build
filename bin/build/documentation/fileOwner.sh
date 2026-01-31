#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Get the file owner name"$'\n'"Argument: file - File to get the owner for"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs the file owner for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Get the file owner name"$'\n'"Argument: file - File to get the owner for"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs the file owner for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Get the file owner name"
usage="fileOwner"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileOwner'$'\e''[0m'$'\n'''$'\n''Get the file owner name'$'\n''Argument: file - File to get the owner for'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Outputs the file owner for each file passed on the command line'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Unable to access file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileOwner'$'\n'''$'\n''Get the file owner name'$'\n''Argument: file - File to get the owner for'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Outputs the file owner for each file passed on the command line'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Unable to access file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.514
