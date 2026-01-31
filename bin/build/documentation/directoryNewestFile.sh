#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Find the newest modified file in a directory"$'\n'"Argument: directory - Directory. Required. Directory to search for the newest file."$'\n'"Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Find the newest modified file in a directory"$'\n'"Argument: directory - Directory. Required. Directory to search for the newest file."$'\n'"Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Find the newest modified file in a directory"
usage="directoryNewestFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryNewestFile'$'\e''[0m'$'\n'''$'\n''Find the newest modified file in a directory'$'\n''Argument: directory - Directory. Required. Directory to search for the newest file.'$'\n''Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryNewestFile'$'\n'''$'\n''Find the newest modified file in a directory'$'\n''Argument: directory - Directory. Required. Directory to search for the newest file.'$'\n''Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.466
