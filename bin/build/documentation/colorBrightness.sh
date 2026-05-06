#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'""
base="colors.sh"
credit="https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="colorBrightness"
fnMarker="colorbrightness"
foundNames=([0]="credit" [1]="argument" [2]="stdin")
line="502"
rawComment="Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11"$'\n'"Return an integer between 0 and 100"$'\n'"Colors are between 0 and 255"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: redValue - Integer. Optional. Red RGB value (0-255)"$'\n'"Argument: greenValue - Integer. Optional. Red RGB value (0-255)"$'\n'"Argument: blueValue - Integer. Optional. Red RGB value (0-255)"$'\n'"stdin: 3 integer values [ Optional ]"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="502"
stdin="3 integer values [ Optional ]"$'\n'""
summary="Return an integer between 0 and 100"
summaryComputed="true"
usage="colorBrightness [ --help ] [ redValue ] [ greenValue ] [ blueValue ]"
