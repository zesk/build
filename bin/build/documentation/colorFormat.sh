#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="format - String. Optional. Formatting string."$'\n'"red - UnsignedInteger. Optional. Red component."$'\n'"green - UnsignedInteger. Optional. Blue component."$'\n'"blue - UnsignedInteger. Optional. Green component."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Take r g b decimal values and convert them to hex color values"$'\n'"Takes arguments or stdin values in groups of 3."$'\n'""
exitCode="0"
file="bin/build/tools/colors.sh"
foundNames=([0]="stdin" [1]="argument")
rawComment="Take r g b decimal values and convert them to hex color values"$'\n'"stdin: list:UnsignedInteger"$'\n'"Argument: format - String. Optional. Formatting string."$'\n'"Argument: red - UnsignedInteger. Optional. Red component."$'\n'"Argument: green - UnsignedInteger. Optional. Blue component."$'\n'"Argument: blue - UnsignedInteger. Optional. Green component."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Takes arguments or stdin values in groups of 3."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769211509"
stdin="list:UnsignedInteger"$'\n'""
summary="Take r g b decimal values and convert them to"
usage="colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mcolorFormat'$'\e''[0m '$'\e''[[blue]m[ format ]'$'\e''[0m '$'\e''[[blue]m[ red ]'$'\e''[0m '$'\e''[[blue]m[ green ]'$'\e''[0m '$'\e''[[blue]m[ blue ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mformat  '$'\e''[[value]mString. Optional. Formatting string.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mred     '$'\e''[[value]mUnsignedInteger. Optional. Red component.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mgreen   '$'\e''[[value]mUnsignedInteger. Optional. Blue component.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mblue    '$'\e''[[value]mUnsignedInteger. Optional. Green component.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Take r g b decimal values and convert them to hex color values'$'\n''Takes arguments or stdin values in groups of 3.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''list:UnsignedInteger'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]'$'\n'''$'\n''    format  String. Optional. Formatting string.'$'\n''    red     UnsignedInteger. Optional. Red component.'$'\n''    green   UnsignedInteger. Optional. Blue component.'$'\n''    blue    UnsignedInteger. Optional. Green component.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Take r g b decimal values and convert them to hex color values'$'\n''Takes arguments or stdin values in groups of 3.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''list:UnsignedInteger'$'\n'''
