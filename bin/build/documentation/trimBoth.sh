#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Trim whitespace from beginning and end of a stream"$'\n'""
file="bin/build/tools/text.sh"
fn="trimBoth"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines"$'\n'""
summary="Trim whitespace from beginning and end of a stream"
usage="trimBoth [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtrimBoth[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Trim whitespace from beginning and end of a stream

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Reads lines from stdin until EOF

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Outputs modified lines
'
# shellcheck disable=SC2016
helpPlain='Usage: trimBoth [ --help ]

    --help  Flag. Optional. Display this help.

Trim whitespace from beginning and end of a stream

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Reads lines from stdin until EOF

Writes to stdout:
Outputs modified lines
'
