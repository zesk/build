#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="backgroundColor - String. Optional. Background color."$'\n'""
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Print the suggested color mode for the current environment"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/console.sh"
fn="consoleConfigureColorMode"
fnMarker="consoleconfigurecolormode"
foundNames=([0]="argument")
line="110"
rawComment="Argument: backgroundColor - String. Optional. Background color."$'\n'"Print the suggested color mode for the current environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="82d47fdc5820e57d7aeb7f061bb09ecb16c35cd7"
sourceLine="110"
summary="Print the suggested color mode for the current environment"
summaryComputed="true"
usage="consoleConfigureColorMode [ backgroundColor ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleConfigureColorMode'$'\e''[0m '$'\e''[[(blue)]m[ backgroundColor ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mbackgroundColor  '$'\e''[[(value)]mString. Optional. Background color.'$'\e''[[(reset)]m'$'\n'''$'\n''Print the suggested color mode for the current environment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: consoleConfigureColorMode [ backgroundColor ]'$'\n'''$'\n''    backgroundColor  String. Optional. Background color.'$'\n'''$'\n''Print the suggested color mode for the current environment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/console.md"
