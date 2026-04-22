#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"message ... - String. Required. Any message to display as the badge"$'\n'""
base="iterm2.sh"
description="Set the badge for the iTerm2 console"$'\n'""
environment="LC_TERMINAL"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Badge"
foundNames=([0]="argument" [1]="environment")
line="664"
lowerFn="iterm2badge"
rawComment="Set the badge for the iTerm2 console"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Argument: message ... - String. Required. Any message to display as the badge"$'\n'"Environment: LC_TERMINAL"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="664"
summary="Set the badge for the iTerm2 console"
summaryComputed="true"
usage="iTerm2Badge [ --ignore | -i ] message ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Badge'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mmessage ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--ignore | -i  '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mmessage ...    '$'\e''[[(value)]mString. Required. Any message to display as the badge'$'\e''[[(reset)]m'$'\n'''$'\n''Set the badge for the iTerm2 console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Badge [ --ignore | -i ] message ...'$'\n'''$'\n''    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''    message ...    String. Required. Any message to display as the badge'$'\n'''$'\n''Set the badge for the iTerm2 console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n'''
documentationPath="documentation/source/tools/iterm2.md"
