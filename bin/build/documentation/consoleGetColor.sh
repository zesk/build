#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="console.sh"
description="Summary: Get the console foreground or background color"$'\n'"Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'"Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'""
file="bin/build/tools/console.sh"
foundNames=()
rawComment="Summary: Get the console foreground or background color"$'\n'"Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'"Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'"Argument: --foreground - Flag. Optional. Get the console text color."$'\n'"Argument: --background - Flag. Optional. Get the console background color."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="91c4bb28f83e34c39b4dcef4774e2addc1f37c12"
summary="Summary: Get the console foreground or background color"
usage="consoleGetColor"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleGetColor'$'\e''[0m'$'\n'''$'\n''Summary: Get the console foreground or background color'$'\n''Gets the RGB console color using an '$'\e''[[(code)]mxterm'$'\e''[[(reset)]m escape sequence supported by some terminals. (usually for background colors)'$'\n''Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/'$'\n''Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash'$'\n''Argument: --foreground - Flag. Optional. Get the console text color.'$'\n''Argument: --background - Flag. Optional. Get the console background color.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleGetColor'$'\n'''$'\n''Summary: Get the console foreground or background color'$'\n''Gets the RGB console color using an xterm escape sequence supported by some terminals. (usually for background colors)'$'\n''Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/'$'\n''Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash'$'\n''Argument: --foreground - Flag. Optional. Get the console text color.'$'\n''Argument: --background - Flag. Optional. Get the console background color.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.481
