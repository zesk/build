#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="stdout: UnsignedInteger"$'\n'"Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'"stdin: Lines are read from standard in and counted"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="stdout: UnsignedInteger"$'\n'"Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'"stdin: Lines are read from standard in and counted"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="stdout: UnsignedInteger"
usage="fileLineCount"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileLineCount'$'\e''[0m'$'\n'''$'\n''stdout: UnsignedInteger'$'\n''Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.'$'\n''This is essentially a wrapper around '$'\e''[[(code)]mwc -l'$'\e''[[(reset)]m which strips whitespace and does type checking.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin.'$'\n''stdin: Lines are read from standard in and counted'$'\n''stdout: '$'\e''[[(code)]mUnsignedInteger'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileLineCount'$'\n'''$'\n''stdout: UnsignedInteger'$'\n''Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.'$'\n''This is essentially a wrapper around wc -l which strips whitespace and does type checking.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: file - File. Optional. Output line count for each file specified. If no files specified, uses stdin.'$'\n''stdin: Lines are read from standard in and counted'$'\n''stdout: UnsignedInteger'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.493
