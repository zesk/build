#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="line.sh"
description="Summary: Output a bar as wide as the console"$'\n'"Output a bar as wide as the console using the \`=\` symbol."$'\n'"Argument: alternateChar - String. Optional. Use an alternate character or string output"$'\n'"Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'"See: consoleColumns"$'\n'"Example:     decorate success \$(consoleLine =-)"$'\n'"Example:     decorate success \$(consoleLine \"- Success \")"$'\n'"Example:     decorate magenta \$(consoleLine +-)"$'\n'""
file="bin/build/tools/decorate/line.sh"
foundNames=()
rawComment="Summary: Output a bar as wide as the console"$'\n'"Output a bar as wide as the console using the \`=\` symbol."$'\n'"Argument: alternateChar - String. Optional. Use an alternate character or string output"$'\n'"Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'"See: consoleColumns"$'\n'"Example:     decorate success \$(consoleLine =-)"$'\n'"Example:     decorate success \$(consoleLine \"- Success \")"$'\n'"Example:     decorate magenta \$(consoleLine +-)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/line.sh"
sourceHash="d4cd740d5d6a84a884fd713f35b747da69c16f00"
summary="Summary: Output a bar as wide as the console"
usage="consoleLine"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleLine'$'\e''[0m'$'\n'''$'\n''Summary: Output a bar as wide as the console'$'\n''Output a bar as wide as the console using the '$'\e''[[(code)]m='$'\e''[[(reset)]m symbol.'$'\n''Argument: alternateChar - String. Optional. Use an alternate character or string output'$'\n''Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is '$'\e''[[(code)]m0'$'\e''[[(reset)]m)'$'\n''See: consoleColumns'$'\n''Example:     decorate success $(consoleLine =-)'$'\n''Example:     decorate success $(consoleLine "- Success ")'$'\n''Example:     decorate magenta $(consoleLine +-)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleLine'$'\n'''$'\n''Summary: Output a bar as wide as the console'$'\n''Output a bar as wide as the console using the = symbol.'$'\n''Argument: alternateChar - String. Optional. Use an alternate character or string output'$'\n''Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is 0)'$'\n''See: consoleColumns'$'\n''Example:     decorate success $(consoleLine =-)'$'\n''Example:     decorate success $(consoleLine "- Success ")'$'\n''Example:     decorate magenta $(consoleLine +-)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.453
