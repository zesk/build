#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\nfile - File. Optional. Output line count for each file specified. If no files specified, uses stdin.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.\nThis is essentially a wrapper around `wc -l` which strips whitespace and does type checking.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="fileLineCount"
fnMarker="filelinecount"
foundNames=([0]="stdout" [1]="argument" [2]="stdin")
line="740"
rawComment=$'stdout: UnsignedInteger\nOutputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.\nThis is essentially a wrapper around `wc -l` which strips whitespace and does type checking.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin.\nstdin: Lines are read from standard in and counted\nstdout: `UnsignedInteger`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="740"
stdin=$'Lines are read from standard in and counted\n'
stdout=$'UnsignedInteger\n`UnsignedInteger`\n'
summary="Outputs the number of lines read from stdin (or supplied"
summaryComputed="true"
usage="fileLineCount [ --help ] [ --handler handler ] [ file ]"
