#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Add iTerm2 support to console"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Init"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="iTerm2Aliases iTerm2PromptSupport"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1768759385"
summary="Add iTerm2 support to console"
usage="iTerm2Init [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2Init[0m [94m[ --ignore | -i ][0m

    [94m--ignore | -i  [1;97mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.[0m

Add iTerm2 support to console

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
helpPlain='Usage: iTerm2Init [ --ignore | -i ]

    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

Add iTerm2 support to console

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
