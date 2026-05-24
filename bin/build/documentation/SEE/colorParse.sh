#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'color - String. Optional. Color to parse.\n--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Parse a color and output R G B decimal values\nTakes arguments or stdin.\n\n'
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="colorParse"
fnMarker="colorparse"
foundNames=([0]="stdin" [1]="argument")
line="695"
rawComment=$'Parse a color and output R G B decimal values\nstdin: list:colors\nArgument: color - String. Optional. Color to parse.\nArgument: --help - Flag. Optional. Display this help.\nTakes arguments or stdin.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="695"
stdin=$'list:colors\n'
summary="Parse a color and output R G B decimal values"
summaryComputed="true"
usage="colorParse [ color ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorParse'$'\e''[0m '$'\e''[[(blue)]m[ color ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcolor   '$'\e''[[(value)]mString. Optional. Color to parse.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Parse a color and output R G B decimal values'$'\n''Takes arguments or stdin.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''list:colors'
# shellcheck disable=SC2016
helpPlain='Usage: colorParse [ color ] [ --help ]'$'\n'''$'\n''    color   String. Optional. Color to parse.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Parse a color and output R G B decimal values'$'\n''Takes arguments or stdin.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''list:colors'
documentationPath="documentation/source/tools/decorate.md"
