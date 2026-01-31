#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="console.sh"
description="Summary: Output the brightness of the background color of the console as a number between 0 and 100"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'"Fetch the brightness of the console using \`consoleGetColor\`"$'\n'"See: consoleGetColor"$'\n'"Output: Integer. between 0 and 100."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - A problem occurred with \`consoleGetColor\`"$'\n'""
file="bin/build/tools/console.sh"
foundNames=()
rawComment="Summary: Output the brightness of the background color of the console as a number between 0 and 100"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'"Fetch the brightness of the console using \`consoleGetColor\`"$'\n'"See: consoleGetColor"$'\n'"Output: Integer. between 0 and 100."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - A problem occurred with \`consoleGetColor\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="91c4bb28f83e34c39b4dcef4774e2addc1f37c12"
summary="Summary: Output the brightness of the background color of the"
usage="consoleBrightness"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleBrightness'$'\e''[0m'$'\n'''$'\n''Summary: Output the brightness of the background color of the console as a number between 0 and 100'$'\n''Argument: --foreground - Flag. Optional. Get the console text color.'$'\n''Argument: --background - Flag. Optional. Get the console background color.'$'\n''Fetch the brightness of the console using '$'\e''[[(code)]mconsoleGetColor'$'\e''[[(reset)]m'$'\n''See: consoleGetColor'$'\n''Output: Integer. between 0 and 100.'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - A problem occurred with '$'\e''[[(code)]mconsoleGetColor'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleBrightness'$'\n'''$'\n''Summary: Output the brightness of the background color of the console as a number between 0 and 100'$'\n''Argument: --foreground - Flag. Optional. Get the console text color.'$'\n''Argument: --background - Flag. Optional. Get the console background color.'$'\n''Fetch the brightness of the console using consoleGetColor'$'\n''See: consoleGetColor'$'\n''Output: Integer. between 0 and 100.'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - A problem occurred with consoleGetColor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.472
