#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--debug - Flag. Optional. Show additional debugging information."$'\n'""
base="colors.sh"
description="Set the terminal color scheme to the specification"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorScheme"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
stdin="Scheme definition with \`colorName=colorValue\` on each line"$'\n'""
summary="Set the terminal color scheme to the specification"
usage="colorScheme [ --help ] [ --handler handler ] [ --debug ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcolorScheme[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --debug ][0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--debug            [1;97mFlag. Optional. Show additional debugging information.[0m

Set the terminal color scheme to the specification

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Scheme definition with [38;2;0;255;0;48;2;0;0;0mcolorName=colorValue[0m on each line
'
# shellcheck disable=SC2016
helpPlain='Usage: colorScheme [ --help ] [ --handler handler ] [ --debug ]

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --debug            Flag. Optional. Show additional debugging information.

Set the terminal color scheme to the specification

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Scheme definition with colorName=colorValue on each line
'
