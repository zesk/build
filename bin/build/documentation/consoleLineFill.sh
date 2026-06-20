#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'textToOutput - String. Optional. Text to display on the new cleared line.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Clears current line of text in the console\n\nIntended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.\n\nIntended to be run on an interactive console. Should support $(tput cols).\n\n'
descriptionLineCount="6"
file="bin/build/tools/colors.sh"
fn="consoleLineFill"
fnMarker="consolelinefill"
foundNames=([0]="summary" [1]="argument")
line="228"
original="consoleLineFill"
rawComment=$'Clears current line of text in the console\nIntended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.\nIntended to be run on an interactive console. Should support $(tput cols).\nSummary: Clear a line in the console\nArgument: textToOutput - String. Optional. Text to display on the new cleared line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="56a1ebebc064dfac20f0f243c277830691edc5b3"
sourceLine="228"
summary="Clear a line in the console"
summaryComputed=""
usage="consoleLineFill [ textToOutput ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleLineFill'$'\e''[0m '$'\e''[[(blue)]m[ textToOutput ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtextToOutput  '$'\e''[[(value)]mString. Optional. Text to display on the new cleared line.'$'\e''[[(reset)]m'$'\n'''$'\n''Clears current line of text in the console'$'\n'''$'\n''Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.'$'\n'''$'\n''Intended to be run on an interactive console. Should support $(tput cols).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: consoleLineFill [ textToOutput ]'$'\n'''$'\n''    textToOutput  String. Optional. Text to display on the new cleared line.'$'\n'''$'\n''Clears current line of text in the console'$'\n'''$'\n''Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.'$'\n'''$'\n''Intended to be run on an interactive console. Should support $(tput cols).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/decorate.md"
