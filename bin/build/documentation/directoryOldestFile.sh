#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="directory - Directory. Required. Directory to search for the oldest file."$'\n'"--find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""
base="file.sh"
description="Find the oldest modified file in a directory"$'\n'""
exitCode="0"
file="bin/build/tools/file.sh"
foundNames=([0]="argument")
rawComment="Find the oldest modified file in a directory"$'\n'"Argument: directory - Directory. Required. Directory to search for the oldest file."$'\n'"Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
summary="Find the oldest modified file in a directory"
usage="directoryOldestFile directory [ --find findArgs ... -- ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdirectoryOldestFile'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --find findArgs ... -- ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mdirectory               '$'\e''[[value]mDirectory. Required. Directory to search for the oldest file.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--find findArgs ... --  '$'\e''[[value]mArguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\e''[[reset]m'$'\n'''$'\n''Find the oldest modified file in a directory'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryOldestFile directory [ --find findArgs ... -- ]'$'\n'''$'\n''    directory               Directory. Required. Directory to search for the oldest file.'$'\n''    --find findArgs ... --  Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\n'''$'\n''Find the oldest modified file in a directory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
