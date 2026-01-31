#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="List the most recently modified file in a directory prefixed with the timestamp"$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="List the most recently modified file in a directory prefixed with the timestamp"$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="List the most recently modified file in a directory prefixed"
usage="fileModifiedRecently"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedRecently'$'\e''[0m'$'\n'''$'\n''List the most recently modified file in a directory prefixed with the timestamp'$'\n''Argument: directory - Directory. Required. Must exists - directory to list.'$'\n''Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileModifiedRecently'$'\n'''$'\n''List the most recently modified file in a directory prefixed with the timestamp'$'\n''Argument: directory - Directory. Required. Must exists - directory to list.'$'\n''Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.465
