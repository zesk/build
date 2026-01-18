#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="textToOutput - String. Optional. Text to display on the new cleared line."$'\n'""
base="colors.sh"
description="Clears current line of text in the console"$'\n'""$'\n'"Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces."$'\n'""$'\n'"Intended to be run on an interactive console. Should support \`tput cols\`."$'\n'""
file="bin/build/tools/colors.sh"
fn="clearLine"
foundNames=([0]="summary" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768758955"
summary="Clear a line in the console"$'\n'""
usage="clearLine [ textToOutput ]"
