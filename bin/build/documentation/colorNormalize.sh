#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Redistribute color values to make brightness adjustments more balanced\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorNormalize"
fnMarker="colornormalize"
foundNames=([0]="argument" [1]="requires")
line="560"
rawComment=$'Redistribute color values to make brightness adjustments more balanced\nArgument: --help - Flag. Optional. Display this help.\nRequires: bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize\n\n'
requires=$'bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="560"
summary="Redistribute color values to make brightness adjustments more balanced"
summaryComputed="true"
usage="colorNormalize [ --help ]"
