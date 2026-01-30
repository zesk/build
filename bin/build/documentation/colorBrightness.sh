#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'""
base="colors.sh"
credit="https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'""
description="Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'""
file="bin/build/tools/colors.sh"
foundNames=([0]="credit" [1]="argument" [2]="stdin")
rawComment="Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'"Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"Argument: greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"Argument: blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'"stdin: 3 integer values [ Optional ]"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="96d8c4382a0d0bcde7815a1c086d749341989d52"
stdin="3 integer values [ Optional ]"$'\n'""
summary="Return an integer between 0 and 100"
usage="colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorBrightness'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ redValue ]'$'\e''[0m '$'\e''[[(blue)]m[ greenValue ]'$'\e''[0m '$'\e''[[(blue)]m[ blueValue ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mredValue    '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mgreenValue  '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mblueValue   '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n'''$'\n''Return an integer between 0 and 100'$'\n''Colors are between 0 and 255'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''3 integer values [ Optional ]'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mcolorBrightness [[(blue)]m[ --help ] [[(blue)]m[ redValue ] [[(blue)]m[ greenValue ] [[(blue)]m[ blueValue ]'$'\n'''$'\n''    [[(blue)]m--help      [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n''    [[(blue)]mredValue    [[(value)]mInteger. Optional. Red RGB value (0-255)[[(reset)]m'$'\n''    [[(blue)]mgreenValue  [[(value)]mInteger. Optional. Red RGB value (0-255)[[(reset)]m'$'\n''    [[(blue)]mblueValue   [[(value)]mInteger. Optional. Red RGB value (0-255)[[(reset)]m'$'\n'''$'\n''Return an integer between 0 and 100'$'\n''Colors are between 0 and 255'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''$'\n''Reads from [[(code)]mstdin[[(reset)]m:'$'\n''3 integer values [ Optional ]'$'\n'''
# elapsed 3.011
