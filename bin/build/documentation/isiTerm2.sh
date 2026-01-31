#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
description="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: LC_TERMINAL"$'\n'"Environment: TERM"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="b59a38e93b87dfec07eac18e712111781b8a471f"
summary="Is the current console iTerm2?"
summaryComputed="true"
usage="isiTerm2 [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misiTerm2'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is the current console iTerm2?'$'\n''Succeeds when LC_TERMINAL is '$'\e''[[(code)]miTerm2'$'\e''[[(reset)]m AND TERM is NOT '$'\e''[[(code)]mscreen'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]misiTerm2 [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Is the current console iTerm2?'$'\n''Succeeds when LC_TERMINAL is [[(code)]miTerm2 AND TERM is NOT [[(code)]mscreen'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'$'\n'''
