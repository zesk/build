#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Add iTerm2 support to console"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
exitCode="0"
file="bin/build/tools/iterm2.sh"
foundNames=([0]="argument" [1]="environment" [2]="see")
rawComment="Add iTerm2 support to console"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Environment: LC_TERMINAL"$'\n'"Environment: TERM"$'\n'"See: iTerm2Aliases iTerm2PromptSupport"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="iTerm2Aliases iTerm2PromptSupport"$'\n'""
sourceModified="1769184734"
summary="Add iTerm2 support to console"
usage="iTerm2Init [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]miTerm2Init'$'\e''[0m '$'\e''[[blue]m[ --ignore | -i ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--ignore | -i  '$'\e''[[value]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[reset]m'$'\n'''$'\n''Add iTerm2 support to console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Init [ --ignore | -i ]'$'\n'''$'\n''    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n'''$'\n''Add iTerm2 support to console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'$'\n'''
