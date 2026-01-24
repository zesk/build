#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="-a - Flag. Optional. Append target (atomically as well)."$'\n'"target - File. Required. File to target"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Write to a file in a single operation to avoid invalid files"$'\n'""
exitCode="0"
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Write to a file in a single operation to avoid invalid files"$'\n'"Argument: -a - Flag. Optional. Append target (atomically as well)."$'\n'"Argument: target - File. Required. File to target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Piped to a temporary file until EOF and then moved to target"$'\n'"stdout: A copy of stdin"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
stdin="Piped to a temporary file until EOF and then moved to target"$'\n'""
stdout="A copy of stdin"$'\n'""
summary="Write to a file in a single operation to avoid"
usage="fileTeeAtomic [ -a ] target [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mfileTeeAtomic'$'\e''[0m '$'\e''[[blue]m[ -a ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mtarget'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m-a      '$'\e''[[value]mFlag. Optional. Append target (atomically as well).'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mtarget  '$'\e''[[value]mFile. Required. File to target'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''A copy of stdin'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileTeeAtomic [ -a ] target [ --help ]'$'\n'''$'\n''    -a      Flag. Optional. Append target (atomically as well).'$'\n''    target  File. Required. File to target'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to stdout:'$'\n''A copy of stdin'$'\n'''
