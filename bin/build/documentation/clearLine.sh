#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="textToOutput - String. Optional. Text to display on the new cleared line."$'\n'""
base="colors.sh"
description="Clears current line of text in the console"$'\n'""$'\n'"Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces."$'\n'""$'\n'"Intended to be run on an interactive console. Should support \`tput cols\`."$'\n'""
file="bin/build/tools/colors.sh"
fn="clearLine"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
summary="Clear a line in the console"$'\n'""
usage="clearLine [ textToOutput ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mclearLine[0m [94m[ textToOutput ][0m

    [94mtextToOutput  [1;97mString. Optional. Text to display on the new cleared line.[0m

Clears current line of text in the console

Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.

Intended to be run on an interactive console. Should support [38;2;0;255;0;48;2;0;0;0mtput cols[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: clearLine [ textToOutput ]

    textToOutput  String. Optional. Text to display on the new cleared line.

Clears current line of text in the console

Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.

Intended to be run on an interactive console. Should support tput cols.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
