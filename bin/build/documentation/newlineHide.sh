#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"text - String. Required. Text to replace."$'\n'"replace - String. Optional. Replacement string for newlines."$'\n'""
base="text.sh"
description="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - String. Required. Text to replace."$'\n'"Argument: replace - String. Optional. Replacement string for newlines."$'\n'"Without arguments, displays help."$'\n'"stdout: The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
stdout="The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""
summary="Hide newlines in text (to ensure single-line output or other"
summaryComputed="true"
usage="newlineHide [ --help ] text [ replace ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnewlineHide'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ replace ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext     '$'\e''[[(value)]mString. Required. Text to replace.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mreplace  '$'\e''[[(value)]mString. Optional. Replacement string for newlines.'$'\e''[[(reset)]m'$'\n'''$'\n''Hide newlines in text (to ensure single-line output or other manipulation)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''The text with the newline replaced with another character, suitable typically for single-line output'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: newlineHide [ --help ] text [ replace ]'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    text     String. Required. Text to replace.'$'\n''    replace  String. Optional. Replacement string for newlines.'$'\n'''$'\n''Hide newlines in text (to ensure single-line output or other manipulation)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''The text with the newline replaced with another character, suitable typically for single-line output'$'\n'''
