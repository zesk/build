#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nvalue - Integer. A return value.\nfrom - Integer. When value matches `from`, instead return `to`\nto - Integer. The value to return when `from` matches `value`\n... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match\n'
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'map a return value from one value to another\n\n'
descriptionLineCount="2"
file="bin/build/tools/sugar.sh"
fn="returnMap"
fnMarker="returnmap"
foundNames=([0]="argument")
line="88"
original="returnMap"
rawComment=$'map a return value from one value to another\nArgument: --help - Flag. Optional. Display this help.\nArgument: value - Integer. A return value.\nArgument: from - Integer. When value matches `from`, instead return `to`\nArgument: to - Integer. The value to return when `from` matches `value`\nArgument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="88"
summary="map a return value from one value to another"
summaryComputed="true"
usage="returnMap [ --help ] [ value ] [ from ] [ to ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnMap'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m '$'\e''[[(blue)]m[ from ]'$'\e''[0m '$'\e''[[(blue)]m[ to ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue   '$'\e''[[(value)]mInteger. A return value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfrom    '$'\e''[[(value)]mInteger. When value matches '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m, instead return '$'\e''[[(code)]mto'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mto      '$'\e''[[(value)]mInteger. The value to return when '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m matches '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mAdditional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\e''[[(reset)]m'$'\n'''$'\n''map a return value from one value to another'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: returnMap [ --help ] [ value ] [ from ] [ to ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    value   Integer. A return value.'$'\n''    from    Integer. When value matches from, instead return to'$'\n''    to      Integer. The value to return when from matches value'$'\n''    ...     Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''map a return value from one value to another'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar.md"
