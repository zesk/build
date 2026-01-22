#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="code ... - UnsignedInteger. String. Exit code value to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="_sugar.sh"
description="Output the exit code as a string"$'\n'""$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnCodeString"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
stdout="exitCodeToken, one per line"$'\n'""
summary="Output the exit code as a string"
usage="returnCodeString [ code ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnCodeString[0m [94m[ code ... ][0m [94m[ --help ][0m

    [94mcode ...  [1;97mUnsignedInteger. String. Exit code value to output.[0m
    [94m--help    [1;97mFlag. Optional. Display this help.[0m

Output the exit code as a string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
exitCodeToken, one per line
'
# shellcheck disable=SC2016
helpPlain='Usage: returnCodeString [ code ... ] [ --help ]

    code ...  UnsignedInteger. String. Exit code value to output.
    --help    Flag. Optional. Display this help.

Output the exit code as a string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
exitCodeToken, one per line
'
