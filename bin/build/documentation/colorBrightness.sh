#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'""
base="colors.sh"
credit="https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'""
description="Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorBrightness"
foundNames=([0]="credit" [1]="argument" [2]="stdin")
rawComment="Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'"Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"Argument: greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"Argument: blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'"stdin: 3 integer values [ Optional ]"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="3770972335552cd2776a277b8b4765f0d98baf44"
stdin="3 integer values [ Optional ]"$'\n'""
summary="Return an integer between 0 and 100"
summaryComputed="true"
usage="colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorBrightness'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ redValue ]'$'\e''[0m '$'\e''[[(blue)]m[ greenValue ]'$'\e''[0m '$'\e''[[(blue)]m[ blueValue ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mredValue    '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mgreenValue  '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mblueValue   '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n'''$'\n''Return an integer between 0 and 100'$'\n''Colors are between 0 and 255'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''3 integer values [ Optional ]'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]'$'\n'''$'\n''    --help      Flag. Optional. Display this help.'$'\n''    redValue    Integer. Optional. Red RGB value (0-255)'$'\n''    greenValue  Integer. Optional. Red RGB value (0-255)'$'\n''    blueValue   Integer. Optional. Red RGB value (0-255)'$'\n'''$'\n''Return an integer between 0 and 100'$'\n''Colors are between 0 and 255'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''3 integer values [ Optional ]'$'\n'''
