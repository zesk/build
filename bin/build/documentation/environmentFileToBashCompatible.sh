#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename ... - File. Optional. One or more files to convert."$'\n'""
base="convert.sh"
description="Takes any environment file and makes it bash-compatible"$'\n'""$'\n'"Outputs the compatible env to stdout"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileToBashCompatible"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceModified="1769063211"
stdin="environment file"$'\n'""
stdout="bash-compatible environment statements"$'\n'""
summary="Takes any environment file and makes it bash-compatible"
usage="environmentFileToBashCompatible [ filename ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileToBashCompatible[0m [94m[ filename ... ][0m

    [94mfilename ...  [1;97mFile. Optional. One or more files to convert.[0m

Takes any environment file and makes it bash-compatible

Outputs the compatible env to stdout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
environment file

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
bash-compatible environment statements
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileToBashCompatible [ filename ... ]

    filename ...  File. Optional. One or more files to convert.

Takes any environment file and makes it bash-compatible

Outputs the compatible env to stdout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
environment file

Writes to stdout:
bash-compatible environment statements
'
