#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--debug - Flag. Optional. Show additional debugging information.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set the terminal color scheme to the specification\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorScheme"
fnMarker="colorscheme"
foundNames=([0]="argument" [1]="stdin")
line="813"
rawComment=$'Set the terminal color scheme to the specification\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --debug - Flag. Optional. Show additional debugging information.\nstdin: Scheme definition with `colorName=colorValue` on each line\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="64a763a2e70568a8f8724961b50fb82c045e8f58"
sourceLine="813"
stdin=$'Scheme definition with `colorName=colorValue` on each line\n'
summary="Set the terminal color scheme to the specification"
summaryComputed="true"
usage="colorScheme [ --help ] [ --handler handler ] [ --debug ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorScheme'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --debug ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--debug            '$'\e''[[(value)]mFlag. Optional. Show additional debugging information.'$'\e''[[(reset)]m'$'\n'''$'\n''Set the terminal color scheme to the specification'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Scheme definition with '$'\e''[[(code)]mcolorName=colorValue'$'\e''[[(reset)]m on each line'
# shellcheck disable=SC2016
helpPlain='Usage: colorScheme [ --help ] [ --handler handler ] [ --debug ]'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --debug            Flag. Optional. Show additional debugging information.'$'\n'''$'\n''Set the terminal color scheme to the specification'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Scheme definition with colorName=colorValue on each line'
documentationPath="documentation/source/tools/decorate.md"
