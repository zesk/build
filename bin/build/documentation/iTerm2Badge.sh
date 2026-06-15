#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"message ... - String. Optional. Any message to display as the badge"$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set the badge for the iTerm2 console"$'\n'""$'\n'""
descriptionLineCount="2"
environment="LC_TERMINAL"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Badge"
fnMarker="iterm2badge"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="environment")
line="665"
rawComment="Summary: Set Badge Message"$'\n'"Set the badge for the iTerm2 console"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Argument: message ... - String. Optional. Any message to display as the badge"$'\n'"stdin: message - String. Optional. Message to display if not supplied as an argument."$'\n'"Environment: LC_TERMINAL"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="addbed4a0b68e5f665a51ab97d2b99c073dd7c02"
sourceLine="665"
stdin="message - String. Optional. Message to display if not supplied as an argument."$'\n'""
summary="Set Badge Message"
summaryComputed=""
usage="iTerm2Badge [ --ignore | -i ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Badge'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--ignore | -i  '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...    '$'\e''[[(value)]mString. Optional. Any message to display as the badge'$'\e''[[(reset)]m'$'\n'''$'\n''Set the badge for the iTerm2 console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''message - String. Optional. Message to display if not supplied as an argument.'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Badge [ --ignore | -i ] [ message ... ]'$'\n'''$'\n''    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''    message ...    String. Optional. Any message to display as the badge'$'\n'''$'\n''Set the badge for the iTerm2 console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n'''$'\n''Reads from stdin:'$'\n''message - String. Optional. Message to display if not supplied as an argument.'
documentationPath="documentation/source/tools/iterm2.md"
