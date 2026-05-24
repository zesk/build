#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
line="251"
rawComment=$'Clears current line of text in the console\nIntended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.\nIntended to be run on an interactive console. Should support $(tput cols).\nSummary: Clear a line in the console\nArgument: textToOutput - String. Optional. Text to display on the new cleared line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="251"
summary="Clear a line in the console"
summaryComputed=""
usage="consoleLineFill [ textToOutput ]"
