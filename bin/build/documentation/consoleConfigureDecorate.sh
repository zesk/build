#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'backgroundColor - String. Optional. Background color.\n--help - Flag. Optional. Display this help.\n'
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Modify the decoration environment for light or dark.\n\nRun this at the top of your script for best results.\n\nUpdate the color scheme for a light or dark scheme\n\n'
descriptionLineCount="6"
file="bin/build/tools/console.sh"
fn="consoleConfigureDecorate"
fnMarker="consoleconfiguredecorate"
foundNames=([0]="argument")
line="142"
rawComment=$'Modify the decoration environment for light or dark.\nRun this at the top of your script for best results.\nArgument: backgroundColor - String. Optional. Background color.\nUpdate the color scheme for a light or dark scheme\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/console.sh"
sourceHash="0e80c2ac41033836c3905696efb51ddeab9575b8"
sourceLine="142"
summary="Modify the decoration environment for light or dark."
summaryComputed="true"
usage="consoleConfigureDecorate [ backgroundColor ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleConfigureDecorate'$'\e''[0m '$'\e''[[(blue)]m[ backgroundColor ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mbackgroundColor  '$'\e''[[(value)]mString. Optional. Background color.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help           '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Modify the decoration environment for light or dark.'$'\n'''$'\n''Run this at the top of your script for best results.'$'\n'''$'\n''Update the color scheme for a light or dark scheme'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: consoleConfigureDecorate [ backgroundColor ] [ --help ]'$'\n'''$'\n''    backgroundColor  String. Optional. Background color.'$'\n''    --help           Flag. Optional. Display this help.'$'\n'''$'\n''Modify the decoration environment for light or dark.'$'\n'''$'\n''Run this at the top of your script for best results.'$'\n'''$'\n''Update the color scheme for a light or dark scheme'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/console.md"
