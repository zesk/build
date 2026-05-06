#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="textToOutput - String. Optional. Text to display on the new cleared line."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Clears current line of text in the console"$'\n'""$'\n'"Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces."$'\n'""$'\n'"Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/colors.sh"
fn="consoleLineFill"
fnMarker="consolelinefill"
foundNames=([0]="summary" [1]="argument")
line="249"
rawComment="Clears current line of text in the console"$'\n'"Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces."$'\n'"Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'"Summary: Clear a line in the console"$'\n'"Argument: textToOutput - String. Optional. Text to display on the new cleared line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="249"
summary="Clear a line in the console"
summaryComputed=""
usage="consoleLineFill [ textToOutput ]"
