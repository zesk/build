#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'""$'\n'""
descriptionLineCount="3"
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="isiTerm2"
fnMarker="isiterm2"
foundNames=([0]="argument" [1]="environment")
line="36"
rawComment="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: LC_TERMINAL"$'\n'"Environment: TERM"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="36"
summary="Is the current console iTerm2?"
summaryComputed="true"
usage="isiTerm2 [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misiTerm2'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is the current console iTerm2?'$'\n''Succeeds when LC_TERMINAL is '$'\e''[[(code)]miTerm2'$'\e''[[(reset)]m AND TERM is NOT '$'\e''[[(code)]mscreen'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'
# shellcheck disable=SC2016
helpPlain='Usage: isiTerm2 [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is the current console iTerm2?'$'\n''Succeeds when LC_TERMINAL is iTerm2 AND TERM is NOT screen'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'
documentationPath="documentation/source/tools/iterm2.md"
