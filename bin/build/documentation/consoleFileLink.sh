#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="--no-app - Flag. Optional. Do not map the application path in \`decoratePath\`"$'\n'"fileName - String. Required. File path to output."$'\n'"text - String. Optional. Text to output linked to file."$'\n'""
base="console.sh"
description="Output a local file link to the console"$'\n'""
file="bin/build/tools/console.sh"
fn="consoleFileLink"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceModified="1768759173"
summary="Output a local file link to the console"
usage="consoleFileLink [ --no-app ] fileName [ text ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconsoleFileLink[0m [94m[ --no-app ][0m [38;2;255;255;0m[35;48;2;0;0;0mfileName[0m[0m [94m[ text ][0m

    [94m--no-app  [1;97mFlag. Optional. Do not map the application path in [38;2;0;255;0;48;2;0;0;0mdecoratePath[0m[0m
    [31mfileName  [1;97mString. Required. File path to output.[0m
    [94mtext      [1;97mString. Optional. Text to output linked to file.[0m

Output a local file link to the console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: consoleFileLink [ --no-app ] fileName [ text ]

    --no-app  Flag. Optional. Do not map the application path in decoratePath
    fileName  String. Required. File path to output.
    text      String. Optional. Text to output linked to file.

Output a local file link to the console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
