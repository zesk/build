#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="color - String. Optional. Color to parse."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Parse a color and output R G B decimal values"$'\n'"Takes arguments or stdin."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="colorParse"
fnMarker="colorparse"
foundNames=([0]="stdin" [1]="argument")
line="693"
rawComment="Parse a color and output R G B decimal values"$'\n'"stdin: list:colors"$'\n'"Argument: color - String. Optional. Color to parse."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Takes arguments or stdin."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="693"
stdin="list:colors"$'\n'""
summary="Parse a color and output R G B decimal values"
summaryComputed="true"
usage="colorParse [ color ] [ --help ]"
