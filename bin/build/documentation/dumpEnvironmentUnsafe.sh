#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output the environment shamelessly (not secure, not recommended)"$'\n'""$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpEnvironmentUnsafe"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1769063211"
summary="Output the environment shamelessly (not secure, not recommended)"
usage="dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdumpEnvironmentUnsafe[0m [94m[ --maximum-length maximumLength ][0m [94m[ --skip-env environmentVariable ][0m [94m[ --show-skipped ][0m [94m[ --help ][0m

    [94m--maximum-length maximumLength  [1;97mPositiveInteger. Optional. The maximum number of characters to output for each environment variable.[0m
    [94m--skip-env environmentVariable  [1;97mEnvironmentVariable. Optional. Skip this environment variable (must match exactly).[0m
    [94m--show-skipped                  [1;97mFlag. Show skipped environment variables.[0m
    [94m--help                          [1;97mFlag. Optional. Display this help.[0m

Output the environment shamelessly (not secure, not recommended)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]

    --maximum-length maximumLength  PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
    --skip-env environmentVariable  EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
    --show-skipped                  Flag. Show skipped environment variables.
    --help                          Flag. Optional. Display this help.

Output the environment shamelessly (not secure, not recommended)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
