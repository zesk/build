#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
# shellcheck source=/dev/null
# shellcheck source=/dev/null
applicationFile="bin/build/tools/debug.sh"
argument="--help - Help"$'\n'"--verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"--name name - String. Optional. Name for verbose mode."$'\n'""
base="debug.sh"
description="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"# shellcheck source=/dev/null"$'\n'""
example="    source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
exitCode="0"
file="bin/build/tools/debug.sh"
foundNames=([0]="argument" [1]="example")
rawComment="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"Argument: --help - Help"$'\n'"Argument: --verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"Argument: --name name - String. Optional. Name for verbose mode."$'\n'"# shellcheck source=/dev/null"$'\n'"Example:     source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769208503"
summary="Check output for content and trigger environment error if found"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]moutputTrigger'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ --verbose ]'$'\e''[0m '$'\e''[[blue]m[ --name name ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help       '$'\e''[[value]mHelp'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--verbose    '$'\e''[[value]mFlag. Optional. Verbose messages when no errors exist.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--name name  '$'\e''[[value]mString. Optional. Name for verbose mode.'$'\e''[[reset]m'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n''Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]'$'\n''# shellcheck source=/dev/null'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Example:'$'\n''    source "$include" > >(outputTrigger source "$include") || return $?'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: outputTrigger [ --help ] [ --verbose ] [ --name name ]'$'\n'''$'\n''    --help       Help'$'\n''    --verbose    Flag. Optional. Verbose messages when no errors exist.'$'\n''    --name name  String. Optional. Name for verbose mode.'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n''Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]'$'\n''# shellcheck source=/dev/null'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    source "$include" > >(outputTrigger source "$include") || return $?'$'\n'''
