#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="envFile ... - File. Required. One or more files to convert."$'\n'""
base="convert.sh"
description="Takes any environment file and makes it docker-compatible"$'\n'""$'\n'"Outputs the compatible env to stdout"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileToDocker"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceModified="1768759914"
summary="Takes any environment file and makes it docker-compatible"
usage="environmentFileToDocker envFile ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileToDocker[0m [38;2;255;255;0m[35;48;2;0;0;0menvFile ...[0m[0m

    [31menvFile ...  [1;97mFile. Required. One or more files to convert.[0m

Takes any environment file and makes it docker-compatible

Outputs the compatible env to stdout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileToDocker envFile ...

    envFile ...  File. Required. One or more files to convert.

Takes any environment file and makes it docker-compatible

Outputs the compatible env to stdout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
