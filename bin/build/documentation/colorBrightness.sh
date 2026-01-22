#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'""
base="colors.sh"
credit="https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'""
description="Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorBrightness"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
stdin="3 integer values [ Optional ]"$'\n'""
summary="Return an integer between 0 and 100"
usage="colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcolorBrightness[0m [94m[ --help ][0m [94m[ redValue ][0m [94m[ greenValue ][0m [94m[ blueValue ][0m

    [94m--help      [1;97mFlag. Optional. Display this help.[0m
    [94mredValue    [1;97mInteger. Optional. Red RGB value (0-255)[0m
    [94mgreenValue  [1;97mInteger. Optional. Red RGB value (0-255)[0m
    [94mblueValue   [1;97mInteger. Optional. Red RGB value (0-255)[0m

Return an integer between 0 and 100
Colors are between 0 and 255

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
3 integer values [ Optional ]
'
# shellcheck disable=SC2016
helpPlain='Usage: colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]

    --help      Flag. Optional. Display this help.
    redValue    Integer. Optional. Red RGB value (0-255)
    greenValue  Integer. Optional. Red RGB value (0-255)
    blueValue   Integer. Optional. Red RGB value (0-255)

Return an integer between 0 and 100
Colors are between 0 and 255

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
3 integer values [ Optional ]
'
