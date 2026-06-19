#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'fileName0 - File. Optional. File to dump.\n--symbol symbolString - String. Optional. Prefix for each output line.\n--lines lineCount - PositiveInteger. Optional. Number of lines to output.\n--help - Flag. Optional. Display this help.\n'
base="dump.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a file for debugging\n\n'
descriptionLineCount="2"
file="bin/build/tools/dump.sh"
fn="dumpFile"
fnMarker="dumpfile"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="198"
rawComment=$'Output a file for debugging\nArgument: fileName0 - File. Optional. File to dump.\nstdin: text (optional)\nstdout: formatted text (optional)\nArgument: --symbol symbolString - String. Optional. Prefix for each output line.\nArgument: --lines lineCount - PositiveInteger. Optional. Number of lines to output.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/dump.sh"
sourceHash="94824e6d87fafcc40e468afc512be10ff8d48ef3"
sourceLine="198"
stdin=$'text (optional)\n'
stdout=$'formatted text (optional)\n'
summary="Output a file for debugging"
summaryComputed="true"
usage="dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdumpFile'$'\e''[0m '$'\e''[[(blue)]m[ fileName0 ]'$'\e''[0m '$'\e''[[(blue)]m[ --symbol symbolString ]'$'\e''[0m '$'\e''[[(blue)]m[ --lines lineCount ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfileName0              '$'\e''[[(value)]mFile. Optional. File to dump.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--symbol symbolString  '$'\e''[[(value)]mString. Optional. Prefix for each output line.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--lines lineCount      '$'\e''[[(value)]mPositiveInteger. Optional. Number of lines to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a file for debugging'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text (optional)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''formatted text (optional)'
# shellcheck disable=SC2016
helpPlain='Usage: dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]'$'\n'''$'\n''    fileName0              File. Optional. File to dump.'$'\n''    --symbol symbolString  String. Optional. Prefix for each output line.'$'\n''    --lines lineCount      PositiveInteger. Optional. Number of lines to output.'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Output a file for debugging'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text (optional)'$'\n'''$'\n''Writes to stdout:'$'\n''formatted text (optional)'
documentationPath="documentation/source/tools/dump.md"
