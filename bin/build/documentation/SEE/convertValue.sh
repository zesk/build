#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nvalue - String. A value.\nfrom - String. When value matches `from`, instead print `to`\nto - String. The value to print when `from` matches `value`\n... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'map a value from one value to another given from-to pairs\n\nPrints the mapped value to stdout\n\n'
descriptionLineCount="4"
file="bin/build/tools/_sugar.sh"
fn="convertValue"
fnMarker="convertvalue"
foundNames=([0]="argument")
line="161"
rawComment=$'map a value from one value to another given from-to pairs\nPrints the mapped value to stdout\nArgument: --help - Flag. Optional. Display this help.\nArgument: value - String. A value.\nArgument: from - String. When value matches `from`, instead print `to`\nArgument: to - String. The value to print when `from` matches `value`\nArgument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="161"
summary="map a value from one value to another given from-to"
summaryComputed="true"
usage="convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconvertValue'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m '$'\e''[[(blue)]m[ from ]'$'\e''[0m '$'\e''[[(blue)]m[ to ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue   '$'\e''[[(value)]mString. A value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfrom    '$'\e''[[(value)]mString. When value matches '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m, instead print '$'\e''[[(code)]mto'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mto      '$'\e''[[(value)]mString. The value to print when '$'\e''[[(code)]mfrom'$'\e''[[(reset)]m matches '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mString. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\e''[[(reset)]m'$'\n'''$'\n''map a value from one value to another given from-to pairs'$'\n'''$'\n''Prints the mapped value to stdout'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    value   String. A value.'$'\n''    from    String. When value matches from, instead print to'$'\n''    to      String. The value to print when from matches value'$'\n''    ...     String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match'$'\n'''$'\n''map a value from one value to another given from-to pairs'$'\n'''$'\n''Prints the mapped value to stdout'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar-core.md"
