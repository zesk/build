#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename ... - File. Optional. Docker environment file to convert."$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"May take a list of files to convert or stdin piped in"$'\n'""$'\n'"Outputs bash-compatible entries to stdout"$'\n'"Any output to stdout is considered valid output"$'\n'"Any output to stderr is errors in the file but is written to be compatible with a bash"$'\n'""$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileDockerToBashCompatible"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceModified="1768759914"
stdin="An environment file of any format"$'\n'""
stdout="Environment file in Bash-compatible format"$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileDockerToBashCompatible [ filename ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileDockerToBashCompatible[0m [94m[ filename ... ][0m

    [94mfilename ...  [1;97mFile. Optional. Docker environment file to convert.[0m

Ensure an environment file is compatible with non-quoted docker environment files
May take a list of files to convert or stdin piped in

Outputs bash-compatible entries to stdout
Any output to stdout is considered valid output
Any output to stderr is errors in the file but is written to be compatible with a bash

Return Code: 1 - if errors occur
Return Code: 0 - if file is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
An environment file of any format

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Environment file in Bash-compatible format
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileDockerToBashCompatible [ filename ... ]

    filename ...  File. Optional. Docker environment file to convert.

Ensure an environment file is compatible with non-quoted docker environment files
May take a list of files to convert or stdin piped in

Outputs bash-compatible entries to stdout
Any output to stdout is considered valid output
Any output to stderr is errors in the file but is written to be compatible with a bash

Return Code: 1 - if errors occur
Return Code: 0 - if file is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
An environment file of any format

Writes to stdout:
Environment file in Bash-compatible format
'
