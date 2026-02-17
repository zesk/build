#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-17
# shellcheck disable=SC2034
argument="fileName0 - File. Optional. File to dump."$'\n'"--symbol symbolString - String. Optional. Prefix for each output line."$'\n'"--lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output a file for debugging"$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpFile"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Output a file for debugging"$'\n'"Argument: fileName0 - File. Optional. File to dump."$'\n'"stdin: text (optional)"$'\n'"stdout: formatted text (optional)"$'\n'"Argument: --symbol symbolString - String. Optional. Prefix for each output line."$'\n'"Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="cbad93d332115968b7f4983bd2f33b00d702f214"
stdin="text (optional)"$'\n'""
stdout="formatted text (optional)"$'\n'""
summary="Output a file for debugging"
summaryComputed="true"
usage="dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='no helpPlain in bin/build/documentation/dumpFile.sh'$'\n'''
# shellcheck disable=SC2016
helpPlain='no helpPlain in bin/build/documentation/dumpFile.sh'$'\n'''
