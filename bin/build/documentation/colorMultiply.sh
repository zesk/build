#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="factor - floatValue. Required. Red RGB value (0-255)"$'\n'"redValue - Integer. Required. Red RGB value (0-255)"$'\n'"greenValue - Integer. Required. Red RGB value (0-255)"$'\n'"blueValue - Integer. Required. Red RGB value (0-255)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Multiply color values by a factor and return the new values"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorMultiply"
foundNames=([0]="argument" [1]="requires")
rawComment="Multiply color values by a factor and return the new values"$'\n'"Argument: factor - floatValue. Required. Red RGB value (0-255)"$'\n'"Argument: redValue - Integer. Required. Red RGB value (0-255)"$'\n'"Argument: greenValue - Integer. Required. Red RGB value (0-255)"$'\n'"Argument: blueValue - Integer. Required. Red RGB value (0-255)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: bc"$'\n'""$'\n'""
requires="bc"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="fc21248154005d496fe709e58062054e9ea1b478"
summary="Multiply color values by a factor and return the new"
summaryComputed="true"
usage="colorMultiply factor redValue greenValue blueValue [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorMultiply'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfactor'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mredValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mgreenValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mblueValue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfactor      '$'\e''[[(value)]mfloatValue. Required. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mredValue    '$'\e''[[(value)]mInteger. Required. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mgreenValue  '$'\e''[[(value)]mInteger. Required. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mblueValue   '$'\e''[[(value)]mInteger. Required. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Multiply color values by a factor and return the new values'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: colorMultiply factor redValue greenValue blueValue [ --help ]'$'\n'''$'\n''    factor      floatValue. Required. Red RGB value (0-255)'$'\n''    redValue    Integer. Required. Red RGB value (0-255)'$'\n''    greenValue  Integer. Required. Red RGB value (0-255)'$'\n''    blueValue   Integer. Required. Red RGB value (0-255)'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Multiply color values by a factor and return the new values'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
