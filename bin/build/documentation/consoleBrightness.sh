#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
description="Fetch the brightness of the console using \`consoleGetColor\`"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - A problem occurred with \`consoleGetColor\`"$'\n'""
file="bin/build/tools/console.sh"
fn="consoleBrightness"
foundNames=""
output="Integer. between 0 and 100."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleGetColor"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceModified="1769063211"
summary="Output the brightness of the background color of the console as a number between 0 and 100"$'\n'""
usage="consoleBrightness [ --foreground ] [ --background ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconsoleBrightness[0m [94m[ --foreground ][0m [94m[ --background ][0m

    [94m--foreground  [1;97mFlag. Optional. Get the console text color.[0m
    [94m--background  [1;97mFlag. Optional. Get the console background color.[0m

Fetch the brightness of the console using [38;2;0;255;0;48;2;0;0;0mconsoleGetColor[0m
Return Code: 0 - Success
Return Code: 1 - A problem occurred with [38;2;0;255;0;48;2;0;0;0mconsoleGetColor[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: consoleBrightness [ --foreground ] [ --background ]

    --foreground  Flag. Optional. Get the console text color.
    --background  Flag. Optional. Get the console background color.

Fetch the brightness of the console using consoleGetColor
Return Code: 0 - Success
Return Code: 1 - A problem occurred with consoleGetColor

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
