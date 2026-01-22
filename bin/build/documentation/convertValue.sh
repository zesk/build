#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. A value."$'\n'"from - String. When value matches \`from\`, instead print \`to\`"$'\n'"to - String. The value to print when \`from\` matches \`value\`"$'\n'"... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="_sugar.sh"
description="map a value from one value to another given from-to pairs"$'\n'""$'\n'"Prints the mapped value to stdout"$'\n'""$'\n'""
file="bin/build/tools/_sugar.sh"
fn="convertValue"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="map a value from one value to another given from-to"
usage="convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconvertValue[0m [94m[ --help ][0m [94m[ value ][0m [94m[ from ][0m [94m[ to ][0m [94m[ ... ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mvalue   [1;97mString. A value.[0m
    [94mfrom    [1;97mString. When value matches [38;2;0;255;0;48;2;0;0;0mfrom[0m, instead print [38;2;0;255;0;48;2;0;0;0mto[0m[0m
    [94mto      [1;97mString. The value to print when [38;2;0;255;0;48;2;0;0;0mfrom[0m matches [38;2;0;255;0;48;2;0;0;0mvalue[0m[0m
    [94m...     [1;97mString. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match[0m

map a value from one value to another given from-to pairs

Prints the mapped value to stdout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]

    --help  Flag. Optional. Display this help.
    value   String. A value.
    from    String. When value matches from, instead print to
    to      String. The value to print when from matches value
    ...     String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match

map a value from one value to another given from-to pairs

Prints the mapped value to stdout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
