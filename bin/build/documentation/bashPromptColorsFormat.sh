#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="text - String. Required. List of color names in a colon separated list."$'\n'""
base="prompt.sh"
description="Given a list of color names, generate the color codes in a colon separated list"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptColorsFormat"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
rawComment="Given a list of color names, generate the color codes in a colon separated list"$'\n'"Argument: text - String. Required. List of color names in a colon separated list."$'\n'"stdout: Outputs color *codes* separated by colons."$'\n'"Requires: decorations read inArray decorate listJoin"$'\n'""$'\n'""
requires="decorations read inArray decorate listJoin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="60ddb2349a8bd4812bf32e6721494912b17756ac"
stdout="Outputs color *codes* separated by colons."$'\n'""
summary="Given a list of color names, generate the color codes"
summaryComputed="true"
usage="bashPromptColorsFormat text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptColorsFormat'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mString. Required. List of color names in a colon separated list.'$'\e''[[(reset)]m'$'\n'''$'\n''Given a list of color names, generate the color codes in a colon separated list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs color '$'\e''[[(cyan)]mcodes'$'\e''[[(reset)]m separated by colons.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorsFormat text'$'\n'''$'\n''    text  String. Required. List of color names in a colon separated list.'$'\n'''$'\n''Given a list of color names, generate the color codes in a colon separated list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs color codes separated by colons.'$'\n'''
