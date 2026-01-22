#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="pid - Integer. Required. Process ID of running process"$'\n'""
base="process.sh"
description="Outputs value of resident memory used by a process, value is in kilobytes"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""
example="    > processMemoryUsage 23"$'\n'""
file="bin/build/tools/process.sh"
fn="processMemoryUsage"
output="423"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceModified="1768760463"
summary="Outputs value of resident memory used by a process, value"
usage="processMemoryUsage pid"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mprocessMemoryUsage[0m [38;2;255;255;0m[35;48;2;0;0;0mpid[0m[0m

    [31mpid  [1;97mInteger. Required. Process ID of running process[0m

Outputs value of resident memory used by a process, value is in kilobytes

Return Code: 0 - Success
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    > processMemoryUsage 23
'
# shellcheck disable=SC2016
helpPlain='Usage: processMemoryUsage pid

    pid  Integer. Required. Process ID of running process

Outputs value of resident memory used by a process, value is in kilobytes

Return Code: 0 - Success
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    > processMemoryUsage 23
'
