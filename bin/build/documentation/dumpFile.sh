#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="dump.sh"
description="Output a file for debugging"$'\n'"Argument: fileName0 - File. Optional. File to dump."$'\n'"stdin: text (optional)"$'\n'"stdout: formatted text (optional)"$'\n'"Argument: --symbol symbolString - String. Optional. Prefix for each output line."$'\n'"Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/dump.sh"
foundNames=()
rawComment="Output a file for debugging"$'\n'"Argument: fileName0 - File. Optional. File to dump."$'\n'"stdin: text (optional)"$'\n'"stdout: formatted text (optional)"$'\n'"Argument: --symbol symbolString - String. Optional. Prefix for each output line."$'\n'"Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="6a45ba93dc346627d009bc14e9582d9ccda6e36e"
summary="Output a file for debugging"
usage="dumpFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdumpFile'$'\e''[0m'$'\n'''$'\n''Output a file for debugging'$'\n''Argument: fileName0 - File. Optional. File to dump.'$'\n''stdin: text (optional)'$'\n''stdout: formatted text (optional)'$'\n''Argument: --symbol symbolString - String. Optional. Prefix for each output line.'$'\n''Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dumpFile'$'\n'''$'\n''Output a file for debugging'$'\n''Argument: fileName0 - File. Optional. File to dump.'$'\n''stdin: text (optional)'$'\n''stdout: formatted text (optional)'$'\n''Argument: --symbol symbolString - String. Optional. Prefix for each output line.'$'\n''Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
