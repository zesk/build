#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value - Integer. A return value."$'\n'"from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="sugar.sh"
description="map a return value from one value to another"$'\n'""$'\n'""
file="bin/build/tools/sugar.sh"
fn="mapReturn"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceModified="1769063211"
summary="map a return value from one value to another"
usage="mapReturn [ --help ] [ value ] [ from ] [ to ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmapReturn[0m [94m[ --help ][0m [94m[ value ][0m [94m[ from ][0m [94m[ to ][0m [94m[ ... ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mvalue   [1;97mInteger. A return value.[0m
    [94mfrom    [1;97mInteger. When value matches [38;2;0;255;0;48;2;0;0;0mfrom[0m, instead return [38;2;0;255;0;48;2;0;0;0mto[0m[0m
    [94mto      [1;97mInteger. The value to return when [38;2;0;255;0;48;2;0;0;0mfrom[0m matches [38;2;0;255;0;48;2;0;0;0mvalue[0m[0m
    [94m...     [1;97mAdditional from-to pairs can be passed, first matching value is used, all values will be examined if none match[0m

map a return value from one value to another

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mapReturn [ --help ] [ value ] [ from ] [ to ] [ ... ]

    --help  Flag. Optional. Display this help.
    value   Integer. A return value.
    from    Integer. When value matches from, instead return to
    to      Integer. The value to return when from matches value
    ...     Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match

map a return value from one value to another

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
