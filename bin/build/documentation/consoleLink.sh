#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="console.sh"
description="Summary: console hyperlinks"$'\n'"Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'"Argument: link - EmptyString. Required. Link to output."$'\n'"Argument: text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/console.sh"
foundNames=()
rawComment="Summary: console hyperlinks"$'\n'"Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'"Argument: link - EmptyString. Required. Link to output."$'\n'"Argument: text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="91c4bb28f83e34c39b4dcef4774e2addc1f37c12"
summary="Summary: console hyperlinks"
usage="consoleLink"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleLink'$'\e''[0m'$'\n'''$'\n''Summary: console hyperlinks'$'\n''Output a hyperlink to the console'$'\n''OSC 8 standard for terminals'$'\n''No way to test ability, I think. Maybe '$'\e''[[(code)]mtput'$'\e''[[(reset)]m.'$'\n''Argument: link - EmptyString. Required. Link to output.'$'\n''Argument: text - String. Optional. Text to display, if none then uses '$'\e''[[(code)]mlink'$'\e''[[(reset)]m.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleLink'$'\n'''$'\n''Summary: console hyperlinks'$'\n''Output a hyperlink to the console'$'\n''OSC 8 standard for terminals'$'\n''No way to test ability, I think. Maybe tput.'$'\n''Argument: link - EmptyString. Required. Link to output.'$'\n''Argument: text - String. Optional. Text to display, if none then uses link.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.51
