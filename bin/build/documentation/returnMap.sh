#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value - Integer. A return value."$'\n'"from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="sugar.sh"
description="map a return value from one value to another"$'\n'""
file="bin/build/tools/sugar.sh"
fn="returnMap"
foundNames=([0]="argument")
line="86"
lowerFn="returnmap"
rawComment="map a return value from one value to another"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - Integer. A return value."$'\n'"Argument: from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"Argument: to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="6c1b25e84cf38f47c9e5d60da397593419cd5433"
sourceLine="86"
summary="map a return value from one value to another"
summaryComputed="true"
usage="returnMap [ --help ] [ value ] [ from ] [ to ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnMap'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m '$'\e''[[(blue)]m[ from ]'$'\e''[0m '$'\e''[[(blue)]m[ to ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue   '$'\e''[[(value)]mInteger. A return value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfrom    '$'\e''[[(value)]mInteger. When value matches '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m, instead return '$'\e''[[(code)]mto'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mto      '$'\e''[[(value)]mInteger. The value to return when '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m matches '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mAdditional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\e''[[(reset)]m'$'\n'''$'\n''map a return value from one value to another'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnMap [ --help ] [ value ] [ from ] [ to ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    value   Integer. A return value.'$'\n''    from    Integer. When value matches from, instead return to'$'\n''    to      Integer. The value to return when from matches value'$'\n''    ...     Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''map a return value from one value to another'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/sugar.md"
