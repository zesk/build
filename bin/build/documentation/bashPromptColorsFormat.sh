#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="prompt.sh"
description="Given a list of color names, generate the color codes in a colon separated list"$'\n'"Argument: text - String. Required. List of color names in a colon separated list."$'\n'"stdout: Outputs color *codes* separated by colons."$'\n'"Requires: decorations read inArray decorate listJoin"$'\n'""
file="bin/build/tools/prompt.sh"
foundNames=()
rawComment="Given a list of color names, generate the color codes in a colon separated list"$'\n'"Argument: text - String. Required. List of color names in a colon separated list."$'\n'"stdout: Outputs color *codes* separated by colons."$'\n'"Requires: decorations read inArray decorate listJoin"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="1ab68393aa28eac81e7693196069615e04e64c26"
summary="Given a list of color names, generate the color codes"
usage="bashPromptColorsFormat"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptColorsFormat'$'\e''[0m'$'\n'''$'\n''Given a list of color names, generate the color codes in a colon separated list'$'\n''Argument: text - String. Required. List of color names in a colon separated list.'$'\n''stdout: Outputs color '$'\e''[[(cyan)]mcodes'$'\e''[[(reset)]m separated by colons.'$'\n''Requires: decorations read inArray decorate listJoin'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorsFormat'$'\n'''$'\n''Given a list of color names, generate the color codes in a colon separated list'$'\n''Argument: text - String. Required. List of color names in a colon separated list.'$'\n''stdout: Outputs color codes separated by colons.'$'\n''Requires: decorations read inArray decorate listJoin'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.463
