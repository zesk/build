#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
credit="https://www.talisman.org/~erlkonig/documents/xterm-color-queries/"$'\n'"https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash"$'\n'""
description="Gets the RGB console color using an \`xterm\` escape sequence supported by some terminals. (usually for background colors)"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/console.sh"
fn="consoleGetColor"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceModified="1768759173"
summary="Get the console foreground or background color"$'\n'""
usage="consoleGetColor [ --foreground ] [ --background ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconsoleGetColor[0m [94m[ --foreground ][0m [94m[ --background ][0m

    [94m--foreground  [1;97mFlag. Optional. Get the console text color.[0m
    [94m--background  [1;97mFlag. Optional. Get the console background color.[0m

Gets the RGB console color using an [38;2;0;255;0;48;2;0;0;0mxterm[0m escape sequence supported by some terminals. (usually for background colors)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: consoleGetColor [ --foreground ] [ --background ]

    --foreground  Flag. Optional. Get the console text color.
    --background  Flag. Optional. Get the console background color.

Gets the RGB console color using an xterm escape sequence supported by some terminals. (usually for background colors)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
