#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="theme.sh"
description="Applies the current theme to text rendered using \`decorateThemelessMode\`"$'\n'""
file="bin/build/tools/decorate/theme.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Applies the current theme to text rendered using \`decorateThemelessMode\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Text to apply current theme to"$'\n'"stdout: Console-ready text"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/theme.sh"
sourceHash="cec9c147aea52bbb59ceaa1d4c8db65022cf93bc"
stdin="Text to apply current theme to"$'\n'""
stdout="Console-ready text"$'\n'""
summary="Applies the current theme to text rendered using \`decorateThemelessMode\`"
summaryComputed="true"
usage="decorateThemed [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateThemed'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Applies the current theme to text rendered using '$'\e''[[(code)]mdecorateThemelessMode'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Text to apply current theme to'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Console-ready text'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorateThemed [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Applies the current theme to text rendered using decorateThemelessMode'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Text to apply current theme to'$'\n'''$'\n''Writes to stdout:'$'\n''Console-ready text'$'\n'''
