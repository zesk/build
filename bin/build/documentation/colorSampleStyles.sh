#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs sample sentences for the `consoleAction` commands to see what they look like.\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorSampleStyles"
fnMarker="colorsamplestyles"
foundNames=([0]="summary")
line="173"
rawComment=$'Summary: Output colors\nOutputs sample sentences for the `consoleAction` commands to see what they look like.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="268db4eebfa21f1472799a690dcd650b6c3639d4"
sourceLine="173"
summary="Output colors"
summaryComputed=""
usage="colorSampleStyles"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorSampleStyles'$'\e''[0m'$'\n'''$'\n''Outputs sample sentences for the '$'\e''[[(code)]mconsoleAction'$'\e''[[(reset)]m commands to see what they look like.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
