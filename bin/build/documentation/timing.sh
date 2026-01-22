#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="command - Executable. Required. Command to run."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--name - String. Optional. Display this help."$'\n'""
base="timing.sh"
description="Time command, similar to \`time\` but uses internal functions"$'\n'"Outputs time as \`timingReport\`"$'\n'""
file="bin/build/tools/timing.sh"
fn="timing"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceModified="1769063211"
summary="Time command, similar to \`time\` but uses internal functions"
usage="timing command [ --help ] [ --name ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtiming[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand[0m[0m [94m[ --help ][0m [94m[ --name ][0m

    [31mcommand  [1;97mExecutable. Required. Command to run.[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m
    [94m--name   [1;97mString. Optional. Display this help.[0m

Time command, similar to [38;2;0;255;0;48;2;0;0;0mtime[0m but uses internal functions
Outputs time as [38;2;0;255;0;48;2;0;0;0mtimingReport[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: timing command [ --help ] [ --name ]

    command  Executable. Required. Command to run.
    --help   Flag. Optional. Display this help.
    --name   String. Optional. Display this help.

Time command, similar to time but uses internal functions
Outputs time as timingReport

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
