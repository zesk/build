#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashStripComments"
fnMarker="bashstripcomments"
foundNames=([0]="summary" [1]="argument")
line="296"
rawComment="Summary: Pipe to strip comments from a bash file"$'\n'"Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="aacd731aa1df64fbee5b48bdf1d0f86bc8ed4f3e"
sourceLine="296"
summary="Pipe to strip comments from a bash file"
summaryComputed=""
usage="bashStripComments [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashStripComments'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Removes literally any line which begins with zero or more whitespace characters and then a '$'\e''[[(code)]m#'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashStripComments [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Removes literally any line which begins with zero or more whitespace characters and then a #.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
