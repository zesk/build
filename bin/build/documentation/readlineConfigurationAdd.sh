#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/readline.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"keyStroke - String. Required."$'\n'"action - String. Required."$'\n'""
base="readline.sh"
description="Add configuration to \`~/.inputrc\` for a key binding"$'\n'""
example="readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""
file="bin/build/tools/readline.sh"
fn="readlineConfigurationAdd"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/readline.sh"
sourceModified="1769063211"
summary="Add configuration to \`~/.inputrc\` for a key binding"
usage="readlineConfigurationAdd [ --help ] keyStroke action"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreadlineConfigurationAdd[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mkeyStroke[0m[0m [38;2;255;255;0m[35;48;2;0;0;0maction[0m[0m

    [94m--help     [1;97mFlag. Optional. Display this help.[0m
    [31mkeyStroke  [1;97mString. Required.[0m
    [31maction     [1;97mString. Required.[0m

Add configuration to [38;2;0;255;0;48;2;0;0;0m~/.inputrc[0m for a key binding

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
readlineConfigurationAdd "\ep" history-search-backward
'
# shellcheck disable=SC2016
helpPlain='Usage: readlineConfigurationAdd [ --help ] keyStroke action

    --help     Flag. Optional. Display this help.
    keyStroke  String. Required.
    action     String. Required.

Add configuration to ~/.inputrc for a key binding

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
readlineConfigurationAdd "\ep" history-search-backward
'
