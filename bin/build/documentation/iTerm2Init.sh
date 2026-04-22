#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Add iTerm2 support to console"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Init"
foundNames=([0]="argument" [1]="environment" [2]="see")
line="829"
lowerFn="iterm2init"
rawComment="Add iTerm2 support to console"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Environment: LC_TERMINAL"$'\n'"Environment: TERM"$'\n'"See: iTerm2Aliases iTerm2PromptSupport"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="iTerm2Aliases iTerm2PromptSupport"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="829"
summary="Add iTerm2 support to console"
summaryComputed="true"
usage="iTerm2Init [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Init'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--ignore | -i  '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n'''$'\n''Add iTerm2 support to console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Init [ --ignore | -i ]'$'\n'''$'\n''    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n'''$'\n''Add iTerm2 support to console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'$'\n'''
documentationPath="documentation/source/tools/iterm2.md"
