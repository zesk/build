#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Argument: text - Text to quote"$'\n'"Output: Single quotes are prefixed with a backslash"$'\n'"Example:     {fn} \"Now I can't not include this in a bash string.\""$'\n'"Without arguments, displays help."$'\n'"stdout: The input text properly quoted"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Quote strings for inclusion in shell quoted strings"$'\n'"Argument: text - Text to quote"$'\n'"Output: Single quotes are prefixed with a backslash"$'\n'"Example:     {fn} \"Now I can't not include this in a bash string.\""$'\n'"Without arguments, displays help."$'\n'"stdout: The input text properly quoted"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Quote strings for inclusion in shell quoted strings"
usage="escapeQuotes"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mescapeQuotes'$'\e''[0m'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Argument: text - Text to quote'$'\n''Output: Single quotes are prefixed with a backslash'$'\n''Example:     escapeQuotes "Now I can'\''t not include this in a bash string."'$'\n''Without arguments, displays help.'$'\n''stdout: The input text properly quoted'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: escapeQuotes'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Argument: text - Text to quote'$'\n''Output: Single quotes are prefixed with a backslash'$'\n''Example:     escapeQuotes "Now I can'\''t not include this in a bash string."'$'\n''Without arguments, displays help.'$'\n''stdout: The input text properly quoted'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.434
