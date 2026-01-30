#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="backgroundColor - String. Optional. Background color."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="console.sh"
description="Modify the decoration environment for light or dark."$'\n'"Run this at the top of your script for best results."$'\n'"Update the color scheme for a light or dark scheme"$'\n'""
file="bin/build/tools/console.sh"
foundNames=([0]="argument")
rawComment="Modify the decoration environment for light or dark."$'\n'"Run this at the top of your script for best results."$'\n'"Argument: backgroundColor - String. Optional. Background color."$'\n'"Update the color scheme for a light or dark scheme"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="5ace3451795bcc77d8e26d50c12a72648cb7758d"
summary="Modify the decoration environment for light or dark."
usage="consoleConfigureDecorate [ backgroundColor ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleConfigureDecorate'$'\e''[0m '$'\e''[[(blue)]m[ backgroundColor ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mbackgroundColor  '$'\e''[[(value)]mString. Optional. Background color.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help           '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Modify the decoration environment for light or dark.'$'\n''Run this at the top of your script for best results.'$'\n''Update the color scheme for a light or dark scheme'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
