#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="color - String. Optional. Color to parse."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Parse a color and output R G B decimal values"$'\n'"Takes arguments or stdin."$'\n'""
file="bin/build/tools/colors.sh"
fn="colorParse"
foundNames=([0]="stdin" [1]="argument")
rawComment="Parse a color and output R G B decimal values"$'\n'"stdin: list:colors"$'\n'"Argument: color - String. Optional. Color to parse."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Takes arguments or stdin."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="3770972335552cd2776a277b8b4765f0d98baf44"
stdin="list:colors"$'\n'""
summary="Parse a color and output R G B decimal values"
summaryComputed="true"
usage="colorParse [ color ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorParse'$'\e''[0m '$'\e''[[(blue)]m[ color ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcolor   '$'\e''[[(value)]mString. Optional. Color to parse.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Parse a color and output R G B decimal values'$'\n''Takes arguments or stdin.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''list:colors'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: colorParse [ color ] [ --help ]'$'\n'''$'\n''    color   String. Optional. Color to parse.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Parse a color and output R G B decimal values'$'\n''Takes arguments or stdin.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''list:colors'$'\n'''
