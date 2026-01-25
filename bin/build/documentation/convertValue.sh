#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. A value."$'\n'"from - String. When value matches \`from\`, instead print \`to\`"$'\n'"to - String. The value to print when \`from\` matches \`value\`"$'\n'"... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="_sugar.sh"
description="map a value from one value to another given from-to pairs"$'\n'"Prints the mapped value to stdout"$'\n'""
exitCode="0"
file="bin/build/tools/_sugar.sh"
foundNames=([0]="argument")
rawComment="map a value from one value to another given from-to pairs"$'\n'"Prints the mapped value to stdout"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. A value."$'\n'"Argument: from - String. When value matches \`from\`, instead print \`to\`"$'\n'"Argument: to - String. The value to print when \`from\` matches \`value\`"$'\n'"Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="map a value from one value to another given from-to"
usage="convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mconvertValue'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ value ]'$'\e''[0m '$'\e''[[blue]m[ from ]'$'\e''[0m '$'\e''[[blue]m[ to ]'$'\e''[0m '$'\e''[[blue]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mvalue   '$'\e''[[value]mString. A value.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mfrom    '$'\e''[[value]mString. When value matches '$'\e''[[code]mfrom'$'\e''[[reset]m, instead print '$'\e''[[code]mto'$'\e''[[reset]m'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mto      '$'\e''[[value]mString. The value to print when '$'\e''[[code]mfrom'$'\e''[[reset]m matches '$'\e''[[code]mvalue'$'\e''[[reset]m'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m...     '$'\e''[[value]mString. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\e''[[reset]m'$'\n'''$'\n''map a value from one value to another given from-to pairs'$'\n''Prints the mapped value to stdout'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    value   String. A value.'$'\n''    from    String. When value matches from, instead print to'$'\n''    to      String. The value to print when from matches value'$'\n''    ...     String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''map a value from one value to another given from-to pairs'$'\n''Prints the mapped value to stdout'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
