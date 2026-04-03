#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
credit="https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'""
description="Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'""
file="bin/build/tools/console.sh"
fn="consoleGetColor"
foundNames=([0]="summary" [1]="credit" [2]="argument")
rawComment="Summary: Get the console foreground or background color"$'\n'"Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'"Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="1eccb7f32254d9dddecdf43da8654cc9ad7cdbc1"
summary="Get the console foreground or background color"$'\n'""
usage="consoleGetColor [ --foreground ] [ --background ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleGetColor'$'\e''[0m '$'\e''[[(blue)]m[ --foreground ]'$'\e''[0m '$'\e''[[(blue)]m[ --background ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--foreground  '$'\e''[[(value)]mFlag. Optional. Get the console text color.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--background  '$'\e''[[(value)]mFlag. Optional. Get the console background color.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets the RGB console color using an '$'\e''[[(code)]mxterm'$'\e''[[(reset)]m escape sequence supported by some terminals. (usually for background colors)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleGetColor [ --foreground ] [ --background ]'$'\n'''$'\n''    --foreground  Flag. Optional. Get the console text color.'$'\n''    --background  Flag. Optional. Get the console background color.'$'\n'''$'\n''Gets the RGB console color using an xterm escape sequence supported by some terminals. (usually for background colors)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
