#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="-a - Flag. Optional. Append target (atomically as well)."$'\n'"target - File. Required. File to target"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Write to a file in a single operation to avoid invalid files"$'\n'""
file="bin/build/tools/file.sh"
fn="fileTeeAtomic"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
stdin="Piped to a temporary file until EOF and then moved to target"$'\n'""
stdout="A copy of stdin"$'\n'""
summary="Write to a file in a single operation to avoid"
usage="fileTeeAtomic [ -a ] target [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileTeeAtomic[0m [94m[ -a ][0m [38;2;255;255;0m[35;48;2;0;0;0mtarget[0m[0m [94m[ --help ][0m

    [94m-a      [1;97mFlag. Optional. Append target (atomically as well).[0m
    [31mtarget  [1;97mFile. Required. File to target[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Write to a file in a single operation to avoid invalid files

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Piped to a temporary file until EOF and then moved to target

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
A copy of stdin
'
# shellcheck disable=SC2016
helpPlain='Usage: fileTeeAtomic [ -a ] target [ --help ]

    -a      Flag. Optional. Append target (atomically as well).
    target  File. Required. File to target
    --help  Flag. Optional. Display this help.

Write to a file in a single operation to avoid invalid files

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Piped to a temporary file until EOF and then moved to target

Writes to stdout:
A copy of stdin
'
