#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'text - String. Required. List of color names in a colon separated list.\n'
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Given a list of color names, generate the color codes in a colon separated list\n\n'
descriptionLineCount="2"
file="bin/build/tools/prompt.sh"
fn="bashPromptColorsFormat"
fnMarker="bashpromptcolorsformat"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
line="196"
rawComment=$'Given a list of color names, generate the color codes in a colon separated list\nArgument: text - String. Required. List of color names in a colon separated list.\nstdout: Outputs color *codes* separated by colons.\nRequires: decorations read inArray decorate listJoin\n\n'
requires=$'decorations read inArray decorate listJoin\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="196"
stdout=$'Outputs color *codes* separated by colons.\n'
summary="Given a list of color names, generate the color codes"
summaryComputed="true"
usage="bashPromptColorsFormat text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptColorsFormat'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mString. Required. List of color names in a colon separated list.'$'\e''[[(reset)]m'$'\n'''$'\n''Given a list of color names, generate the color codes in a colon separated list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs color '$'\e''[[(cyan)]mcodes'$'\e''[[(reset)]m separated by colons.'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorsFormat text'$'\n'''$'\n''    text  String. Required. List of color names in a colon separated list.'$'\n'''$'\n''Given a list of color names, generate the color codes in a colon separated list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs color codes separated by colons.'
documentationPath="documentation/source/tools/prompt.md"
