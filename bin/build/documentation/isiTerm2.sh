#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
description="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="isiTerm2"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1769063211"
summary="Is the current console iTerm2?"
usage="isiTerm2 [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misiTerm2[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Is the current console iTerm2?
Succeeds when LC_TERMINAL is [38;2;0;255;0;48;2;0;0;0miTerm2[0m AND TERM is NOT [38;2;0;255;0;48;2;0;0;0mscreen[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- LC_TERMINAL
- TERM
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isiTerm2 [ --help ]

    --help  Flag. Optional. Display this help.

Is the current console iTerm2?
Succeeds when LC_TERMINAL is iTerm2 AND TERM is NOT screen

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- LC_TERMINAL
- TERM
- 
'
