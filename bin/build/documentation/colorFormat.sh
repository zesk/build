#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="format - String. Optional. Formatting string."$'\n'"red - UnsignedInteger. Optional. Red component."$'\n'"green - UnsignedInteger. Optional. Blue component."$'\n'"blue - UnsignedInteger. Optional. Green component."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Take r g b decimal values and convert them to hex color values"$'\n'"Takes arguments or stdin values in groups of 3."$'\n'""
file="bin/build/tools/colors.sh"
fn="colorFormat"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
stdin="list:UnsignedInteger"$'\n'""
summary="Take r g b decimal values and convert them to"
usage="colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcolorFormat[0m [94m[ format ][0m [94m[ red ][0m [94m[ green ][0m [94m[ blue ][0m [94m[ --help ][0m

    [94mformat  [1;97mString. Optional. Formatting string.[0m
    [94mred     [1;97mUnsignedInteger. Optional. Red component.[0m
    [94mgreen   [1;97mUnsignedInteger. Optional. Blue component.[0m
    [94mblue    [1;97mUnsignedInteger. Optional. Green component.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Take r g b decimal values and convert them to hex color values
Takes arguments or stdin values in groups of 3.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
list:UnsignedInteger
'
# shellcheck disable=SC2016
helpPlain='Usage: colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]

    format  String. Optional. Formatting string.
    red     UnsignedInteger. Optional. Red component.
    green   UnsignedInteger. Optional. Blue component.
    blue    UnsignedInteger. Optional. Green component.
    --help  Flag. Optional. Display this help.

Take r g b decimal values and convert them to hex color values
Takes arguments or stdin values in groups of 3.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
list:UnsignedInteger
'
