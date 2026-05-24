#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--foreground - Flag. Optional. Get the console text color.\n--background - Flag. Optional. Get the console background color.\n'
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Fetch the brightness of the console using `consoleGetColor`\n\n'
descriptionLineCount="2"
file="bin/build/tools/console.sh"
fn="consoleBrightness"
fnMarker="consolebrightness"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="output" [4]="return_code")
line="95"
output=$'Integer. between 0 and 100.\n'
rawComment=$'Summary: Output the brightness of the background color of the console as a number between 0 and 100\nArgument: --foreground - Flag. Optional. Get the console text color.\nArgument: --background - Flag. Optional. Get the console background color.\nFetch the brightness of the console using `consoleGetColor`\nSee: consoleGetColor\nOutput: Integer. between 0 and 100.\nReturn Code: 0 - Success\nReturn Code: 1 - A problem occurred with `consoleGetColor`\n\n'
return_code=$'0 - Success\n1 - A problem occurred with `consoleGetColor`\n'
see=$'consoleGetColor\n'
sourceFile="bin/build/tools/console.sh"
sourceHash="82d47fdc5820e57d7aeb7f061bb09ecb16c35cd7"
sourceLine="95"
summary="Output the brightness of the background color of the console as a number between 0 and 100"
summaryComputed=""
usage="consoleBrightness [ --foreground ] [ --background ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleBrightness'$'\e''[0m '$'\e''[[(blue)]m[ --foreground ]'$'\e''[0m '$'\e''[[(blue)]m[ --background ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--foreground  '$'\e''[[(value)]mFlag. Optional. Get the console text color.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--background  '$'\e''[[(value)]mFlag. Optional. Get the console background color.'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch the brightness of the console using '$'\e''[[(code)]mconsoleGetColor'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - A problem occurred with '$'\e''[[(code)]mconsoleGetColor'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: consoleBrightness [ --foreground ] [ --background ]'$'\n'''$'\n''    --foreground  Flag. Optional. Get the console text color.'$'\n''    --background  Flag. Optional. Get the console background color.'$'\n'''$'\n''Fetch the brightness of the console using consoleGetColor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - A problem occurred with consoleGetColor'
documentationPath="documentation/source/tools/console.md"
