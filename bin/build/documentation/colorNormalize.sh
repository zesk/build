#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Redistribute color values to make brightness adjustments more balanced"$'\n'""
file="bin/build/tools/colors.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="Redistribute color values to make brightness adjustments more balanced"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize"$'\n'""$'\n'""
requires="bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="9f54e9ae3d6bd1960826e3412b3edfd9c241f895"
summary="Redistribute color values to make brightness adjustments more balanced"
summaryComputed="true"
usage="colorNormalize [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorNormalize'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Redistribute color values to make brightness adjustments more balanced'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: colorNormalize [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  Flag. Optional. Display this help.'$'\n'''$'\n''Redistribute color values to make brightness adjustments more balanced'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 3.392
