#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"message ... - String. Required. Any message to display as the badge"$'\n'""
base="iterm2.sh"
description="Set the badge for the iTerm2 console"$'\n'""
environment="LC_TERMINAL"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Badge"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1769063211"
summary="Set the badge for the iTerm2 console"
usage="iTerm2Badge [ --ignore | -i ] message ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2Badge[0m [94m[ --ignore | -i ][0m [38;2;255;255;0m[35;48;2;0;0;0mmessage ...[0m[0m

    [94m--ignore | -i  [1;97mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.[0m
    [31mmessage ...    [1;97mString. Required. Any message to display as the badge[0m

Set the badge for the iTerm2 console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- LC_TERMINAL
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Badge [ --ignore | -i ] message ...

    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
    message ...    String. Required. Any message to display as the badge

Set the badge for the iTerm2 console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- LC_TERMINAL
- 
'
