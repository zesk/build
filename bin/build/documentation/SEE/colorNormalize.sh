#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Redistribute color values to make brightness adjustments more balanced\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorNormalize"
fnMarker="colornormalize"
foundNames=([0]="argument" [1]="requires")
line="560"
rawComment=$'Redistribute color values to make brightness adjustments more balanced\nArgument: --help - Flag. Optional. Display this help.\nRequires: bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize\n\n'
requires=$'bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="560"
summary="Redistribute color values to make brightness adjustments more balanced"
summaryComputed="true"
usage="colorNormalize [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorNormalize'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Redistribute color values to make brightness adjustments more balanced'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: colorNormalize [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Redistribute color values to make brightness adjustments more balanced'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/decorate.md"
