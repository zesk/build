#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="textToOutput - String. Optional. Text to display on the new cleared line."$'\n'""
base="colors.sh"
description="Clears current line of text in the console"$'\n'"Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces."$'\n'"Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'""
file="bin/build/tools/colors.sh"
fn="consoleLineFill"
foundNames=([0]="summary" [1]="argument")
rawComment="Clears current line of text in the console"$'\n'"Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces."$'\n'"Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'"Summary: Clear a line in the console"$'\n'"Argument: textToOutput - String. Optional. Text to display on the new cleared line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="bdf073eb6d0e0790651cc6c692be3c1964cf5e39"
summary="Clear a line in the console"$'\n'""
usage="consoleLineFill [ textToOutput ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleLineFill'$'\e''[0m '$'\e''[[(blue)]m[ textToOutput ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtextToOutput  '$'\e''[[(value)]mString. Optional. Text to display on the new cleared line.'$'\e''[[(reset)]m'$'\n'''$'\n''Clears current line of text in the console'$'\n''Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.'$'\n''Intended to be run on an interactive console. Should support $(tput cols).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleLineFill [ textToOutput ]'$'\n'''$'\n''    textToOutput  String. Optional. Text to display on the new cleared line.'$'\n'''$'\n''Clears current line of text in the console'$'\n''Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.'$'\n''Intended to be run on an interactive console. Should support $(tput cols).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
