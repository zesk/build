#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
description="Fetch the brightness of the console using \`consoleGetColor\`"$'\n'""
file="bin/build/tools/console.sh"
fn="consoleBrightness"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="output" [4]="return_code")
output="Integer. between 0 and 100."$'\n'""
rawComment="Summary: Output the brightness of the background color of the console as a number between 0 and 100"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'"Fetch the brightness of the console using \`consoleGetColor\`"$'\n'"See: consoleGetColor"$'\n'"Output: Integer. between 0 and 100."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - A problem occurred with \`consoleGetColor\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - A problem occurred with \`consoleGetColor\`"$'\n'""
see="consoleGetColor"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="1eccb7f32254d9dddecdf43da8654cc9ad7cdbc1"
summary="Output the brightness of the background color of the console as a number between 0 and 100"$'\n'""
usage="consoleBrightness [ --foreground ] [ --background ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleBrightness'$'\e''[0m '$'\e''[[(blue)]m[ --foreground ]'$'\e''[0m '$'\e''[[(blue)]m[ --background ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--foreground  '$'\e''[[(value)]mFlag. Optional. Get the console text color.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--background  '$'\e''[[(value)]mFlag. Optional. Get the console background color.'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch the brightness of the console using '$'\e''[[(code)]mconsoleGetColor'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - A problem occurred with '$'\e''[[(code)]mconsoleGetColor'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleBrightness [ --foreground ] [ --background ]'$'\n'''$'\n''    --foreground  Flag. Optional. Get the console text color.'$'\n''    --background  Flag. Optional. Get the console background color.'$'\n'''$'\n''Fetch the brightness of the console using consoleGetColor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - A problem occurred with consoleGetColor'$'\n'''
