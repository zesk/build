#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="file ... - Optional. One or more files to get size of."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="No documentation for \`fileSize\`."$'\n'""
file="bin/build/tools/file.sh"
fn="fileSize"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="return_code")
rawComment="Argument: file ... - Optional. One or more files to get size of."$'\n'"stdin: File. One or more files to get size of."$'\n'"stdout: UnsignedInteger"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="91d537b691b9a05e675b0b8e8fc9b5d80f144523"
stdin="File. One or more files to get size of."$'\n'""
stdout="UnsignedInteger"$'\n'""
summary="undocumented"
usage="fileSize [ file ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileSize'$'\e''[0m '$'\e''[[(blue)]m[ file ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile ...  '$'\e''[[(value)]mOptional. One or more files to get size of.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]mfileSize'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''File. One or more files to get size of.'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileSize [ file ... ] [ --help ]'$'\n'''$'\n''    file ...  Optional. One or more files to get size of.'$'\n''    --help    Flag. Optional. Display this help.'$'\n'''$'\n''No documentation for fileSize.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n'''$'\n''Reads from stdin:'$'\n''File. One or more files to get size of.'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''
