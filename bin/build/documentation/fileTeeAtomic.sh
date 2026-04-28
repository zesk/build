#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-28
# shellcheck disable=SC2034
argument="-a - Flag. Optional. Append target (atomically as well)."$'\n'"target - File. Required. File to target"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Write to a file in a single operation to avoid invalid files"$'\n'"EXPERIMENTAL not a lot of testing of this don't use quite yet."$'\n'""
file="bin/build/tools/file.sh"
fn="fileTeeAtomic"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="summary")
line="842"
lowerFn="fileteeatomic"
rawComment="Write to a file in a single operation to avoid invalid files"$'\n'"Argument: -a - Flag. Optional. Append target (atomically as well)."$'\n'"Argument: target - File. Required. File to target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Piped to a temporary file until EOF and then moved to target"$'\n'"stdout: A copy of stdin"$'\n'"Summary: tee but atomic (EXPERIMENTAL)"$'\n'"EXPERIMENTAL not a lot of testing of this don't use quite yet."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="842"
stdin="Piped to a temporary file until EOF and then moved to target"$'\n'""
stdout="A copy of stdin"$'\n'""
summary="tee but atomic (EXPERIMENTAL)"$'\n'""
usage="fileTeeAtomic [ -a ] target [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTeeAtomic'$'\e''[0m '$'\e''[[(blue)]m[ -a ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-a      '$'\e''[[(value)]mFlag. Optional. Append target (atomically as well).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtarget  '$'\e''[[(value)]mFile. Required. File to target'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n''EXPERIMENTAL not a lot of testing of this don'\''t use quite yet.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''A copy of stdin'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileTeeAtomic [ -a ] target [ --help ]'$'\n'''$'\n''    -a      Flag. Optional. Append target (atomically as well).'$'\n''    target  File. Required. File to target'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n''EXPERIMENTAL not a lot of testing of this don'\''t use quite yet.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to stdout:'$'\n''A copy of stdin'$'\n'''
documentationPath="documentation/source/tools/file.md"
