#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="color - String. Optional. Color to parse."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Parse a color and output R G B decimal values"$'\n'"Takes arguments or stdin."$'\n'""
file="bin/build/tools/colors.sh"
fn="colorParse"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1769063211"
stdin="list:colors"$'\n'""
summary="Parse a color and output R G B decimal values"
usage="colorParse [ color ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcolorParse[0m [94m[ color ][0m [94m[ --help ][0m

    [94mcolor   [1;97mString. Optional. Color to parse.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Parse a color and output R G B decimal values
Takes arguments or stdin.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
list:colors
'
# shellcheck disable=SC2016
helpPlain='Usage: colorParse [ color ] [ --help ]

    color   String. Optional. Color to parse.
    --help  Flag. Optional. Display this help.

Parse a color and output R G B decimal values
Takes arguments or stdin.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
list:colors
'
