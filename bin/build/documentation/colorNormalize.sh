#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Redistribute color values to make brightness adjustments more balanced"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorNormalize"
fnMarker="colornormalize"
foundNames=([0]="argument" [1]="requires")
line="558"
rawComment="Redistribute color values to make brightness adjustments more balanced"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize"$'\n'""$'\n'""
requires="bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="558"
summary="Redistribute color values to make brightness adjustments more balanced"
summaryComputed="true"
usage="colorNormalize [ --help ]"
