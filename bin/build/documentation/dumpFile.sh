#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="fileName0 - File. Optional. File to dump."$'\n'"--symbol symbolString - String. Optional. Prefix for each output line."$'\n'"--lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output a file for debugging"$'\n'""
exitCode="0"
file="bin/build/tools/dump.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Output a file for debugging"$'\n'"Argument: fileName0 - File. Optional. File to dump."$'\n'"stdin: text (optional)"$'\n'"stdout: formatted text (optional)"$'\n'"Argument: --symbol symbolString - String. Optional. Prefix for each output line."$'\n'"Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
stdin="text (optional)"$'\n'""
stdout="formatted text (optional)"$'\n'""
summary="Output a file for debugging"
usage="dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdumpFile'$'\e''[0m '$'\e''[[blue]m[ fileName0 ]'$'\e''[0m '$'\e''[[blue]m[ --symbol symbolString ]'$'\e''[0m '$'\e''[[blue]m[ --lines lineCount ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mfileName0              '$'\e''[[value]mFile. Optional. File to dump.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--symbol symbolString  '$'\e''[[value]mString. Optional. Prefix for each output line.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--lines lineCount      '$'\e''[[value]mPositiveInteger. Optional. Number of lines to output.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help                 '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Output a file for debugging'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''text (optional)'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''formatted text (optional)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]'$'\n'''$'\n''    fileName0              File. Optional. File to dump.'$'\n''    --symbol symbolString  String. Optional. Prefix for each output line.'$'\n''    --lines lineCount      PositiveInteger. Optional. Number of lines to output.'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Output a file for debugging'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text (optional)'$'\n'''$'\n''Writes to stdout:'$'\n''formatted text (optional)'$'\n'''
