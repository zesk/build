#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="fileLineCount"
fnMarker="filelinecount"
foundNames=([0]="stdout" [1]="argument" [2]="stdin")
line="736"
rawComment="stdout: UnsignedInteger"$'\n'"Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'"stdin: Lines are read from standard in and counted"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="736"
stdin="Lines are read from standard in and counted"$'\n'""
stdout="UnsignedInteger"$'\n'"\`UnsignedInteger\`"$'\n'""
summary="Outputs the number of lines read from stdin (or supplied"
summaryComputed="true"
usage="fileLineCount [ --help ] [ --handler handler ] [ file ]"
