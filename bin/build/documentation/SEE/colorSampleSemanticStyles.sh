#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs sample sentences for the `action` commands to see what they look like.\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorSampleSemanticStyles"
fnMarker="colorsamplesemanticstyles"
foundNames=([0]="summary")
line="215"
rawComment=$'Summary: Output colors\nOutputs sample sentences for the `action` commands to see what they look like.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="215"
summary="Output colors"
summaryComputed=""
usage="colorSampleSemanticStyles"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorSampleSemanticStyles'$'\e''[0m'$'\n'''$'\n''Outputs sample sentences for the '$'\e''[[(code)]maction'$'\e''[[(reset)]m commands to see what they look like.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: colorSampleSemanticStyles'$'\n'''$'\n''Outputs sample sentences for the action commands to see what they look like.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/decorate.md"
