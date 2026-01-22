#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Ensures blank lines are singular"$'\n'"Used often to clean up markdown \`.md\` files, but can be used for any line-based configuration file which allows blank lines."$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="singleBlankLines"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines where any blank lines are replaced with a single blank line."$'\n'""
summary="Ensures blank lines are singular"
usage="singleBlankLines [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255msingleBlankLines[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Ensures blank lines are singular
Used often to clean up markdown [38;2;0;255;0;48;2;0;0;0m.md[0m files, but can be used for any line-based configuration file which allows blank lines.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Reads lines from stdin until EOF

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Outputs modified lines where any blank lines are replaced with a single blank line.
'
# shellcheck disable=SC2016
helpPlain='Usage: singleBlankLines [ --help ]

    --help  Flag. Optional. Display this help.

Ensures blank lines are singular
Used often to clean up markdown .md files, but can be used for any line-based configuration file which allows blank lines.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Reads lines from stdin until EOF

Writes to stdout:
Outputs modified lines where any blank lines are replaced with a single blank line.
'
