#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="number - Float. Optional. Floating point number to convert to integer."$'\n'""
base="float.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Convert float to an integer, round down always"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/float.sh"
fn="floatTruncate"
fnMarker="floattruncate"
foundNames=([0]="argument")
line="27"
rawComment="Argument: number - Float. Optional. Floating point number to convert to integer."$'\n'"Convert float to an integer, round down always"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/float.sh"
sourceHash="e1ffb94734224e23fb5aec666a9a3ea259b0c325"
sourceLine="27"
summary="Convert float to an integer, round down always"
summaryComputed="true"
usage="floatTruncate [ number ]"
