#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Write to a file in a single operation to avoid invalid files"$'\n'"Argument: -a - Flag. Optional. Append target (atomically as well)."$'\n'"Argument: target - File. Required. File to target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Piped to a temporary file until EOF and then moved to target"$'\n'"stdout: A copy of stdin"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Write to a file in a single operation to avoid invalid files"$'\n'"Argument: -a - Flag. Optional. Append target (atomically as well)."$'\n'"Argument: target - File. Required. File to target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Piped to a temporary file until EOF and then moved to target"$'\n'"stdout: A copy of stdin"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Write to a file in a single operation to avoid"
usage="fileTeeAtomic"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTeeAtomic'$'\e''[0m'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n''Argument: -a - Flag. Optional. Append target (atomically as well).'$'\n''Argument: target - File. Required. File to target'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdin: Piped to a temporary file until EOF and then moved to target'$'\n''stdout: A copy of stdin'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileTeeAtomic'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n''Argument: -a - Flag. Optional. Append target (atomically as well).'$'\n''Argument: target - File. Required. File to target'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdin: Piped to a temporary file until EOF and then moved to target'$'\n''stdout: A copy of stdin'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.504
