#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
credit="https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'""
description="Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/console.sh"
fn="consoleGetColor"
foundNames=([0]="summary" [1]="credit" [2]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/console.sh"
sourceModified="1768759173"
summary="Get the console foreground or background color"$'\n'""
usage="consoleGetColor [ --foreground ] [ --background ]"
