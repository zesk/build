#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'""
base="text.sh"
description="Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'""
file="bin/build/tools/text.sh"
fn="fileLineCount"
foundNames=([0]="stdout" [1]="argument" [2]="stdin")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768759798"
stdin="Lines are read from standard in and counted"$'\n'""
stdout="UnsignedInteger"$'\n'"\`UnsignedInteger\`"$'\n'""
summary="Outputs the number of lines read from stdin (or supplied"
usage="fileLineCount [ --help ] [ --handler handler ] [ file ]"
