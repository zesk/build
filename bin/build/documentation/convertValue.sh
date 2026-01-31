#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="map a value from one value to another given from-to pairs"$'\n'"Prints the mapped value to stdout"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. A value."$'\n'"Argument: from - String. When value matches \`from\`, instead print \`to\`"$'\n'"Argument: to - String. The value to print when \`from\` matches \`value\`"$'\n'"Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="map a value from one value to another given from-to pairs"$'\n'"Prints the mapped value to stdout"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. A value."$'\n'"Argument: from - String. When value matches \`from\`, instead print \`to\`"$'\n'"Argument: to - String. The value to print when \`from\` matches \`value\`"$'\n'"Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="map a value from one value to another given from-to"
usage="convertValue"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconvertValue'$'\e''[0m'$'\n'''$'\n''map a value from one value to another given from-to pairs'$'\n''Prints the mapped value to stdout'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: value - String. A value.'$'\n''Argument: from - String. When value matches '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m, instead print '$'\e''[[(code)]mto'$'\e''[[(reset)]m'$'\n''Argument: to - String. The value to print when '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m matches '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m'$'\n''Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: convertValue'$'\n'''$'\n''map a value from one value to another given from-to pairs'$'\n''Prints the mapped value to stdout'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: value - String. A value.'$'\n''Argument: from - String. When value matches from, instead print to'$'\n''Argument: to - String. The value to print when from matches value'$'\n''Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
