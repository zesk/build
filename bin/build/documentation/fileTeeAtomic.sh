#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="-a - Flag. Optional. Append target (atomically as well)."$'\n'"target - File. Required. File to target"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Write to a file in a single operation to avoid invalid files"$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Write to a file in a single operation to avoid invalid files"$'\n'"Argument: -a - Flag. Optional. Append target (atomically as well)."$'\n'"Argument: target - File. Required. File to target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Piped to a temporary file until EOF and then moved to target"$'\n'"stdout: A copy of stdin"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
stdin="Piped to a temporary file until EOF and then moved to target"$'\n'""
stdout="A copy of stdin"$'\n'""
summary="Write to a file in a single operation to avoid"
summaryComputed="true"
usage="fileTeeAtomic [ -a ] target [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTeeAtomic'$'\e''[0m '$'\e''[[(blue)]m[ -a ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-a      '$'\e''[[(value)]mFlag. Optional. Append target (atomically as well).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtarget  '$'\e''[[(value)]mFile. Required. File to target'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''A copy of stdin'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mfileTeeAtomic [[(blue)]m[ -a ] [[(bold)]m[[(magenta)]mtarget [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m-a      [[(value)]mFlag. Optional. Append target (atomically as well).[[(reset)]m'$'\n''    [[(red)]mtarget  [[(value)]mFile. Required. File to target[[(reset)]m'$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''$'\n''Reads from [[(code)]mstdin[[(reset)]m:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to [[(code)]mstdout[[(reset)]m:'$'\n''A copy of stdin'$'\n'''
