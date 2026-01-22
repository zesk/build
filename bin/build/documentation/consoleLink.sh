#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="link - EmptyString. Required. Link to output."$'\n'"text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="console.sh"
description="Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'""
file="bin/build/tools/console.sh"
fn="consoleLink"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceModified="1768759173"
summary="console hyperlinks"$'\n'""
usage="consoleLink link [ text ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconsoleLink[0m [38;2;255;255;0m[35;48;2;0;0;0mlink[0m[0m [94m[ text ][0m [94m[ --help ][0m

    [31mlink    [1;97mEmptyString. Required. Link to output.[0m
    [94mtext    [1;97mString. Optional. Text to display, if none then uses [38;2;0;255;0;48;2;0;0;0mlink[0m.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Output a hyperlink to the console
OSC 8 standard for terminals
No way to test ability, I think. Maybe [38;2;0;255;0;48;2;0;0;0mtput[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: consoleLink link [ text ] [ --help ]

    link    EmptyString. Required. Link to output.
    text    String. Optional. Text to display, if none then uses link.
    --help  Flag. Optional. Display this help.

Output a hyperlink to the console
OSC 8 standard for terminals
No way to test ability, I think. Maybe tput.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
