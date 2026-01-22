#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"pid - Process ID of running process"$'\n'""
base="process.sh"
description="Outputs value of virtual memory allocated for a process, value is in kilobytes"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""
example="    processVirtualMemoryAllocation 23"$'\n'""
file="bin/build/tools/process.sh"
fn="processVirtualMemoryAllocation"
foundNames=""
output="423"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceModified="1769063211"
summary="Outputs value of virtual memory allocated for a process, value"
usage="processVirtualMemoryAllocation [ --help ] [ pid ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mprocessVirtualMemoryAllocation[0m [94m[ --help ][0m [94m[ pid ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mpid     [1;97mProcess ID of running process[0m

Outputs value of virtual memory allocated for a process, value is in kilobytes

Return Code: 0 - Success
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    processVirtualMemoryAllocation 23
'
# shellcheck disable=SC2016
helpPlain='Usage: processVirtualMemoryAllocation [ --help ] [ pid ]

    --help  Flag. Optional. Display this help.
    pid     Process ID of running process

Outputs value of virtual memory allocated for a process, value is in kilobytes

Return Code: 0 - Success
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    processVirtualMemoryAllocation 23
'
