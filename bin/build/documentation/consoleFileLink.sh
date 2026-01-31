#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--no-app - Flag. Optional. Do not map the application path in \`decoratePath\`"$'\n'"fileName - String. Required. File path to output."$'\n'"text - String. Optional. Text to output linked to file."$'\n'""
base="console.sh"
description="Output a local file link to the console"$'\n'""
file="bin/build/tools/console.sh"
foundNames=([0]="argument")
rawComment="Output a local file link to the console"$'\n'"Argument: --no-app - Flag. Optional. Do not map the application path in \`decoratePath\`"$'\n'"Argument: fileName - String. Required. File path to output."$'\n'"Argument: text - String. Optional. Text to output linked to file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="91c4bb28f83e34c39b4dcef4774e2addc1f37c12"
summary="Output a local file link to the console"
summaryComputed="true"
usage="consoleFileLink [ --no-app ] fileName [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleFileLink'$'\e''[0m '$'\e''[[(blue)]m[ --no-app ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfileName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--no-app  '$'\e''[[(value)]mFlag. Optional. Do not map the application path in '$'\e''[[(code)]mdecoratePath'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfileName  '$'\e''[[(value)]mString. Required. File path to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext      '$'\e''[[(value)]mString. Optional. Text to output linked to file.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a local file link to the console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mconsoleFileLink [[(blue)]m[ --no-app ] [[(bold)]m[[(magenta)]mfileName [[(blue)]m[ text ]'$'\n'''$'\n''    [[(blue)]m--no-app  [[(value)]mFlag. Optional. Do not map the application path in [[(code)]mdecoratePath'$'\n''    [[(red)]mfileName  [[(value)]mString. Required. File path to output.'$'\n''    [[(blue)]mtext      [[(value)]mString. Optional. Text to output linked to file.'$'\n'''$'\n''Output a local file link to the console'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
