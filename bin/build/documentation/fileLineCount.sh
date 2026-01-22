#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"file - File. Optional. Output line count for each file specified. If no files specified, uses stdin."$'\n'""
base="text.sh"
description="Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately."$'\n'"This is essentially a wrapper around \`wc -l\` which strips whitespace and does type checking."$'\n'""
file="bin/build/tools/text.sh"
fn="fileLineCount"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="Lines are read from standard in and counted"$'\n'""
stdout="UnsignedInteger"$'\n'"\`UnsignedInteger\`"$'\n'""
summary="Outputs the number of lines read from stdin (or supplied"
usage="fileLineCount [ --help ] [ --handler handler ] [ file ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileLineCount[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ file ][0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94mfile               [1;97mFile. Optional. Output line count for each file specified. If no files specified, uses stdin.[0m

Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.
This is essentially a wrapper around [38;2;0;255;0;48;2;0;0;0mwc -l[0m which strips whitespace and does type checking.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Lines are read from standard in and counted

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
UnsignedInteger
[38;2;0;255;0;48;2;0;0;0mUnsignedInteger[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: fileLineCount [ --help ] [ --handler handler ] [ file ]

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    file               File. Optional. Output line count for each file specified. If no files specified, uses stdin.

Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.
This is essentially a wrapper around wc -l which strips whitespace and does type checking.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Lines are read from standard in and counted

Writes to stdout:
UnsignedInteger
UnsignedInteger
'
