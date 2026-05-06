#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="factor - floatValue. Required. Red RGB value (0-255)"$'\n'"redValue - Integer. Required. Red RGB value (0-255)"$'\n'"greenValue - Integer. Required. Red RGB value (0-255)"$'\n'"blueValue - Integer. Required. Red RGB value (0-255)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Multiply color values by a factor and return the new values"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorMultiply"
fnMarker="colormultiply"
foundNames=([0]="argument" [1]="requires")
line="721"
rawComment="Multiply color values by a factor and return the new values"$'\n'"Argument: factor - floatValue. Required. Red RGB value (0-255)"$'\n'"Argument: redValue - Integer. Required. Red RGB value (0-255)"$'\n'"Argument: greenValue - Integer. Required. Red RGB value (0-255)"$'\n'"Argument: blueValue - Integer. Required. Red RGB value (0-255)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: bc"$'\n'""$'\n'""
requires="bc"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="721"
summary="Multiply color values by a factor and return the new"
summaryComputed="true"
usage="colorMultiply factor redValue greenValue blueValue [ --help ]"
