#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-23
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nredValue - Integer. Optional. Red RGB value (0-255)\ngreenValue - Integer. Optional. Red RGB value (0-255)\nblueValue - Integer. Optional. Red RGB value (0-255)\n'
base="colors.sh"
credit=$'https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return an integer between 0 and 100\nColors are between 0 and 255\n\n'
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="colorBrightness"
fnMarker="colorbrightness"
foundNames=([0]="credit" [1]="argument" [2]="stdin")
line="542"
original="colorBrightness"
rawComment=$'Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11\nReturn an integer between 0 and 100\nColors are between 0 and 255\nArgument: --help - Flag. Optional. Display this help.\nArgument: redValue - Integer. Optional. Red RGB value (0-255)\nArgument: greenValue - Integer. Optional. Red RGB value (0-255)\nArgument: blueValue - Integer. Optional. Red RGB value (0-255)\nstdin: 3 integer values [ Optional ]\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="3c5d29e3e1c2d6229bfddf23fce762fb65faba52"
sourceLine="542"
stdin=$'3 integer values [ Optional ]\n'
summary="Return an integer between 0 and 100"
summaryComputed="true"
usage="colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorBrightness'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ redValue ]'$'\e''[0m '$'\e''[[(blue)]m[ greenValue ]'$'\e''[0m '$'\e''[[(blue)]m[ blueValue ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mredValue    '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mgreenValue  '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mblueValue   '$'\e''[[(value)]mInteger. Optional. Red RGB value (0-255)'$'\e''[[(reset)]m'$'\n'''$'\n''Return an integer between 0 and 100'$'\n''Colors are between 0 and 255'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''3 integer values [ Optional ]'
# shellcheck disable=SC2016
helpPlain='Usage: colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]'$'\n'''$'\n''    --help      Flag. Optional. Display this help.'$'\n''    redValue    Integer. Optional. Red RGB value (0-255)'$'\n''    greenValue  Integer. Optional. Red RGB value (0-255)'$'\n''    blueValue   Integer. Optional. Red RGB value (0-255)'$'\n'''$'\n''Return an integer between 0 and 100'$'\n''Colors are between 0 and 255'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''3 integer values [ Optional ]'
documentationPath="documentation/source/tools/decorate.md"
