#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Find the oldest modified file in a directory"$'\n'"Argument: directory - Directory. Required. Directory to search for the oldest file."$'\n'"Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Find the oldest modified file in a directory"$'\n'"Argument: directory - Directory. Required. Directory to search for the oldest file."$'\n'"Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Find the oldest modified file in a directory"
usage="directoryOldestFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryOldestFile'$'\e''[0m'$'\n'''$'\n''Find the oldest modified file in a directory'$'\n''Argument: directory - Directory. Required. Directory to search for the oldest file.'$'\n''Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryOldestFile'$'\n'''$'\n''Find the oldest modified file in a directory'$'\n''Argument: directory - Directory. Required. Directory to search for the oldest file.'$'\n''Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.474
