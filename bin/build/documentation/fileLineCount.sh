#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'""
base="text.sh"
description="Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'""
file="bin/build/tools/text.sh"
fn="fileLineCount"
foundNames=([0]="stdout" [1]="argument" [2]="stdin")
line="693"
lowerFn="filelinecount"
rawComment="stdout: UnsignedInteger"$'\n'"Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'"stdin: Lines are read from standard in and counted"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="50153fd5ef57624e1e417cf7f8cf53ca2489a784"
sourceLine="693"
stdin="Lines are read from standard in and counted"$'\n'""
stdout="UnsignedInteger"$'\n'"\`UnsignedInteger\`"$'\n'""
summary="Outputs the number of lines read from stdin (or supplied"
summaryComputed="true"
usage="fileLineCount [ --help ] [ --handler handler ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileLineCount'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile               '$'\e''[[(value)]mFile. Optional. Output line count for each file specified. If no files specified, uses stdin.'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.'$'\n''This is essentially a wrapper around '$'\e''[[(code)]mwc -l'$'\e''[[(reset)]m which strips whitespace and does type checking.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Lines are read from standard in and counted'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger'$'\n'''$'\e''[[(code)]mUnsignedInteger'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileLineCount [ --help ] [ --handler handler ] [ file ]'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    file               File. Optional. Output line count for each file specified. If no files specified, uses stdin.'$'\n'''$'\n''Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.'$'\n''This is essentially a wrapper around wc -l which strips whitespace and does type checking.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Lines are read from standard in and counted'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n''UnsignedInteger'$'\n'''
documentationPath="documentation/source/tools/file.md"
