#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="link - EmptyString. Required. Link to output."$'\n'"text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="console.sh"
description="Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'""
exitCode="0"
file="bin/build/tools/console.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: console hyperlinks"$'\n'"Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'"Argument: link - EmptyString. Required. Link to output."$'\n'"Argument: text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769209815"
summary="console hyperlinks"$'\n'""
usage="consoleLink link [ text ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mconsoleLink'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mlink'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ text ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mlink    '$'\e''[[value]mEmptyString. Required. Link to output.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mtext    '$'\e''[[value]mString. Optional. Text to display, if none then uses '$'\e''[[code]mlink'$'\e''[[reset]m.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Output a hyperlink to the console'$'\n''OSC 8 standard for terminals'$'\n''No way to test ability, I think. Maybe '$'\e''[[code]mtput'$'\e''[[reset]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleLink link [ text ] [ --help ]'$'\n'''$'\n''    link    EmptyString. Required. Link to output.'$'\n''    text    String. Optional. Text to display, if none then uses link.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Output a hyperlink to the console'$'\n''OSC 8 standard for terminals'$'\n''No way to test ability, I think. Maybe tput.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
