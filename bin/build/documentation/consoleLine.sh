#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate/line.sh"
argument="alternateChar - String. Optional. Use an alternate character or string output"$'\n'"offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'""
base="line.sh"
description="Output a bar as wide as the console using the \`=\` symbol."$'\n'""
example="    decorate success \$(consoleLine =-)"$'\n'"    decorate success \$(consoleLine \"- Success \")"$'\n'"    decorate magenta \$(consoleLine +-)"$'\n'""
exitCode="0"
file="bin/build/tools/decorate/line.sh"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example")
rawComment="Summary: Output a bar as wide as the console"$'\n'"Output a bar as wide as the console using the \`=\` symbol."$'\n'"Argument: alternateChar - String. Optional. Use an alternate character or string output"$'\n'"Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'"See: consoleColumns"$'\n'"Example:     decorate success \$(consoleLine =-)"$'\n'"Example:     decorate success \$(consoleLine \"- Success \")"$'\n'"Example:     decorate magenta \$(consoleLine +-)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleColumns"$'\n'""
sourceModified="1769190911"
summary="Output a bar as wide as the console"$'\n'""
usage="consoleLine [ alternateChar ] [ offset ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mconsoleLine'$'\e''[0m '$'\e''[[blue]m[ alternateChar ]'$'\e''[0m '$'\e''[[blue]m[ offset ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]malternateChar  '$'\e''[[value]mString. Optional. Use an alternate character or string output'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]moffset         '$'\e''[[value]mInteger. Optional. an integer offset to increase or decrease the size of the bar (default is '$'\e''[[code]m0'$'\e''[[reset]m)'$'\e''[[reset]m'$'\n'''$'\n''Output a bar as wide as the console using the '$'\e''[[code]m='$'\e''[[reset]m symbol.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate success $(consoleLine =-)'$'\n''    decorate success $(consoleLine "- Success ")'$'\n''    decorate magenta $(consoleLine +-)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleLine [ alternateChar ] [ offset ]'$'\n'''$'\n''    alternateChar  String. Optional. Use an alternate character or string output'$'\n''    offset         Integer. Optional. an integer offset to increase or decrease the size of the bar (default is 0)'$'\n'''$'\n''Output a bar as wide as the console using the = symbol.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate success $(consoleLine =-)'$'\n''    decorate success $(consoleLine "- Success ")'$'\n''    decorate magenta $(consoleLine +-)'$'\n'''
