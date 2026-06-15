#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="none"
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the iTerm2 version"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Version"
fnMarker="iterm2version"
foundNames=([0]="requires")
line="722"
rawComment="Output the iTerm2 version"$'\n'"Requires: stty"$'\n'""$'\n'""
requires="stty"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="addbed4a0b68e5f665a51ab97d2b99c073dd7c02"
sourceLine="722"
summary="Output the iTerm2 version"
summaryComputed="true"
usage="iTerm2Version"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Version'$'\e''[0m'$'\n'''$'\n''Output the iTerm2 version'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Version'$'\n'''$'\n''Output the iTerm2 version'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/iterm2.md"
