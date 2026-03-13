#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-13
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"text - String. Required. Text to replace."$'\n'"replace - String. Optional. Replacement string for newlines. Default is \`␤\`"$'\n'""
base="text.sh"
description="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="newlineHide"
foundNames=([0]="summary" [1]="argument" [2]="stdout")
rawComment="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Summary: Replace newlines in text with a replacement token for single-line output"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - String. Required. Text to replace."$'\n'"Argument: replace - String. Optional. Replacement string for newlines. Default is \`␤\`"$'\n'"Without arguments, displays help."$'\n'"stdout: The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="f0c5212f3e402f51e272ac32015e5e0be9f2581c"
stdout="The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""
summary="Replace newlines in text with a replacement token for single-line output"$'\n'""
usage="newlineHide [ --help ] text [ replace ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnewlineHide'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ replace ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext     '$'\e''[[(value)]mString. Required. Text to replace.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mreplace  '$'\e''[[(value)]mString. Optional. Replacement string for newlines. Default is '$'\e''[[(code)]m␤'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Hide newlines in text (to ensure single-line output or other manipulation)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''The text with the newline replaced with another character, suitable typically for single-line output'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: newlineHide [ --help ] text [ replace ]'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    text     String. Required. Text to replace.'$'\n''    replace  String. Optional. Replacement string for newlines. Default is ␤'$'\n'''$'\n''Hide newlines in text (to ensure single-line output or other manipulation)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''The text with the newline replaced with another character, suitable typically for single-line output'$'\n'''
