#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'""
base="text.sh"
description="Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="stdout" [1]="argument" [2]="stdin")
rawComment="stdout: UnsignedInteger"$'\n'"Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'"stdin: Lines are read from standard in and counted"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="fe2d9b708c7989f56c14d5c18c68077ff92c9081"
stdin="Lines are read from standard in and counted"$'\n'""
stdout="UnsignedInteger"$'\n'"\`UnsignedInteger\`"$'\n'""
summary="Outputs the number of lines read from stdin (or supplied"
usage="fileLineCount [ --help ] [ --handler handler ] [ file ]"
