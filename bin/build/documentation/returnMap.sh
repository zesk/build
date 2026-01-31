#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="sugar.sh"
description="map a return value from one value to another"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - Integer. A return value."$'\n'"Argument: from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"Argument: to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
file="bin/build/tools/sugar.sh"
foundNames=()
rawComment="map a return value from one value to another"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - Integer. A return value."$'\n'"Argument: from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"Argument: to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="661eda875f626c8591389d4c5e16fe409793c6ba"
summary="map a return value from one value to another"
usage="returnMap"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnMap'$'\e''[0m'$'\n'''$'\n''map a return value from one value to another'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: value - Integer. A return value.'$'\n''Argument: from - Integer. When value matches '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m, instead return '$'\e''[[(code)]mto'$'\e''[[(reset)]m'$'\n''Argument: to - Integer. The value to return when '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m matches '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m'$'\n''Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnMap'$'\n'''$'\n''map a return value from one value to another'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: value - Integer. A return value.'$'\n''Argument: from - Integer. When value matches from, instead return to'$'\n''Argument: to - Integer. The value to return when from matches value'$'\n''Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.572
