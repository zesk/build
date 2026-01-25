#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate/line.sh"
argument="barText - String. Required. Text to fill line with, repeated. If not specified uses \`-\`"$'\n'"displayText - String. Optional.  Text to display on the line before the fill bar."$'\n'""
base="line.sh"
description="Output a line and fill columns with a character"$'\n'""
exitCode="0"
file="bin/build/tools/decorate/line.sh"
foundNames=([0]="argument")
rawComment="Output a line and fill columns with a character"$'\n'"Argument: barText - String. Required. Text to fill line with, repeated. If not specified uses \`-\`"$'\n'"Argument: displayText - String. Optional.  Text to display on the line before the fill bar."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769227354"
summary="Output a line and fill columns with a character"
usage="consoleHeadingLine barText [ displayText ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mconsoleHeadingLine'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mbarText'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ displayText ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mbarText      '$'\e''[[value]mString. Required. Text to fill line with, repeated. If not specified uses '$'\e''[[code]m-'$'\e''[[reset]m'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mdisplayText  '$'\e''[[value]mString. Optional.  Text to display on the line before the fill bar.'$'\e''[[reset]m'$'\n'''$'\n''Output a line and fill columns with a character'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleHeadingLine barText [ displayText ]'$'\n'''$'\n''    barText      String. Required. Text to fill line with, repeated. If not specified uses -'$'\n''    displayText  String. Optional.  Text to display on the line before the fill bar.'$'\n'''$'\n''Output a line and fill columns with a character'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
