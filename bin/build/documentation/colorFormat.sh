#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="format - String. Optional. Formatting string."$'\n'"red - UnsignedInteger. Optional. Red component."$'\n'"green - UnsignedInteger. Optional. Blue component."$'\n'"blue - UnsignedInteger. Optional. Green component."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Take r g b decimal values and convert them to hex color values"$'\n'"Takes arguments or stdin values in groups of 3."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="colorFormat"
fnMarker="colorformat"
foundNames=([0]="stdin" [1]="argument")
line="654"
rawComment="Take r g b decimal values and convert them to hex color values"$'\n'"stdin: list:UnsignedInteger"$'\n'"Argument: format - String. Optional. Formatting string."$'\n'"Argument: red - UnsignedInteger. Optional. Red component."$'\n'"Argument: green - UnsignedInteger. Optional. Blue component."$'\n'"Argument: blue - UnsignedInteger. Optional. Green component."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Takes arguments or stdin values in groups of 3."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="654"
stdin="list:UnsignedInteger"$'\n'""
summary="Take r g b decimal values and convert them to"
summaryComputed="true"
usage="colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]"
