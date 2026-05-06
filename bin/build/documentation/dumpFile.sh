#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="fileName0 - File. Optional. File to dump."$'\n'"--symbol symbolString - String. Optional. Prefix for each output line."$'\n'"--lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a file for debugging"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/dump.sh"
fn="dumpFile"
fnMarker="dumpfile"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="198"
rawComment="Output a file for debugging"$'\n'"Argument: fileName0 - File. Optional. File to dump."$'\n'"stdin: text (optional)"$'\n'"stdout: formatted text (optional)"$'\n'"Argument: --symbol symbolString - String. Optional. Prefix for each output line."$'\n'"Argument: --lines lineCount - PositiveInteger. Optional. Number of lines to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="63d0b744477aa020f81137dccf35c889f1754a76"
sourceLine="198"
stdin="text (optional)"$'\n'""
stdout="formatted text (optional)"$'\n'""
summary="Output a file for debugging"
summaryComputed="true"
usage="dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]"
