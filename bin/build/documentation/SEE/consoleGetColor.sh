#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
credit="https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/console.sh"
fn="consoleGetColor"
fnMarker="consolegetcolor"
foundNames=([0]="summary" [1]="credit" [2]="argument")
line="18"
rawComment="Summary: Get the console foreground or background color"$'\n'"Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'"Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="82d47fdc5820e57d7aeb7f061bb09ecb16c35cd7"
sourceLine="18"
summary="Get the console foreground or background color"
summaryComputed=""
usage="consoleGetColor [ --foreground ] [ --background ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleGetColor'$'\e''[0m '$'\e''[[(blue)]m[ --foreground ]'$'\e''[0m '$'\e''[[(blue)]m[ --background ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--foreground  '$'\e''[[(value)]mFlag. Optional. Get the console text color.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--background  '$'\e''[[(value)]mFlag. Optional. Get the console background color.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets the RGB console color using an '$'\e''[[(code)]mxterm'$'\e''[[(reset)]m escape sequence supported by some terminals. (usually for background colors)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: consoleGetColor [ --foreground ] [ --background ]'$'\n'''$'\n''    --foreground  Flag. Optional. Get the console text color.'$'\n''    --background  Flag. Optional. Get the console background color.'$'\n'''$'\n''Gets the RGB console color using an xterm escape sequence supported by some terminals. (usually for background colors)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/console.md"
