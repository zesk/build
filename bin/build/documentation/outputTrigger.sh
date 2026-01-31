#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
# shellcheck source=/dev/null
# shellcheck source=/dev/null
argument="none"
base="debug.sh"
description="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"Argument: --help - Help"$'\n'"Argument: --verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"Argument: --name name - String. Optional. Name for verbose mode."$'\n'"# shellcheck source=/dev/null"$'\n'"Example:     source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=()
rawComment="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"Argument: --help - Help"$'\n'"Argument: --verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"Argument: --name name - String. Optional. Name for verbose mode."$'\n'"# shellcheck source=/dev/null"$'\n'"Example:     source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Check output for content and trigger environment error if found"
usage="outputTrigger"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]moutputTrigger'$'\e''[0m'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n''Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]'$'\n''Argument: --help - Help'$'\n''Argument: --verbose - Flag. Optional. Verbose messages when no errors exist.'$'\n''Argument: --name name - String. Optional. Name for verbose mode.'$'\n''# shellcheck source=/dev/null'$'\n''Example:     source "$include" > >(outputTrigger source "$include") || return $?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: outputTrigger'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n''Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]'$'\n''Argument: --help - Help'$'\n''Argument: --verbose - Flag. Optional. Verbose messages when no errors exist.'$'\n''Argument: --name name - String. Optional. Name for verbose mode.'$'\n''# shellcheck source=/dev/null'$'\n''Example:     source "$include" > >(outputTrigger source "$include") || return $?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.522
