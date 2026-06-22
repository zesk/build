#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs sample sentences for the `consoleAction` commands to see what they look like.\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorSampleStyles"
fnMarker="colorsamplestyles"
foundNames=([0]="summary" [1]="stdout")
line="173"
original="colorSampleStyles"
rawComment=$'Summary: Output colors\nOutputs sample sentences for the `consoleAction` commands to see what they look like.\nstdout: ConsoleText\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="480be5db852b12675144ab1e6476bc78bcb875fa"
sourceLine="173"
stdout=$'ConsoleText\n'
summary="Output colors"
summaryComputed=""
usage="colorSampleStyles"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcolorSampleStyles'$'\e''[0m'$'\n'''$'\n''Outputs sample sentences for the '$'\e''[[(code)]mconsoleAction'$'\e''[[(reset)]m commands to see what they look like.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''ConsoleText'
# shellcheck disable=SC2016
helpPlain='Usage: colorSampleStyles'$'\n'''$'\n''Outputs sample sentences for the consoleAction commands to see what they look like.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''ConsoleText'
documentationPath="documentation/source/tools/decorate.md"
