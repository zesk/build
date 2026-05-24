#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
line="504"
rawComment=$'Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11\nReturn an integer between 0 and 100\nColors are between 0 and 255\nArgument: --help - Flag. Optional. Display this help.\nArgument: redValue - Integer. Optional. Red RGB value (0-255)\nArgument: greenValue - Integer. Optional. Red RGB value (0-255)\nArgument: blueValue - Integer. Optional. Red RGB value (0-255)\nstdin: 3 integer values [ Optional ]\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="504"
stdin=$'3 integer values [ Optional ]\n'
summary="Return an integer between 0 and 100"
summaryComputed="true"
usage="colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]"
