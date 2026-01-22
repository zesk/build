#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="factor - floatValue. Required. Red RGB value (0-255)"$'\n'"redValue - Integer. Required. Red RGB value (0-255)"$'\n'"greenValue - Integer. Required. Red RGB value (0-255)"$'\n'"blueValue - Integer. Required. Red RGB value (0-255)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Multiply color values by a factor and return the new values"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorMultiply"
requires="bc"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
summary="Multiply color values by a factor and return the new"
usage="colorMultiply factor redValue greenValue blueValue [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcolorMultiply[0m [38;2;255;255;0m[35;48;2;0;0;0mfactor[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mredValue[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mgreenValue[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mblueValue[0m[0m [94m[ --help ][0m

    [31mfactor      [1;97mfloatValue. Required. Red RGB value (0-255)[0m
    [31mredValue    [1;97mInteger. Required. Red RGB value (0-255)[0m
    [31mgreenValue  [1;97mInteger. Required. Red RGB value (0-255)[0m
    [31mblueValue   [1;97mInteger. Required. Red RGB value (0-255)[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Multiply color values by a factor and return the new values

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: colorMultiply factor redValue greenValue blueValue [ --help ]

    factor      floatValue. Required. Red RGB value (0-255)
    redValue    Integer. Required. Red RGB value (0-255)
    greenValue  Integer. Required. Red RGB value (0-255)
    blueValue   Integer. Required. Red RGB value (0-255)
    --help      Flag. Optional. Display this help.

Multiply color values by a factor and return the new values

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
