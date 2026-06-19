#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ntext - String. Required. Text to replace.\nreplace - String. Optional. Replacement string for newlines. Default is `␤`\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Hide newlines in text (to ensure single-line output or other manipulation)\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="stringHideNewlines"
fnMarker="stringhidenewlines"
foundNames=([0]="summary" [1]="argument" [2]="stdout")
line="181"
rawComment=$'Hide newlines in text (to ensure single-line output or other manipulation)\nSummary: Replace newlines in text with a replacement token for single-line output\nArgument: --help - Flag. Optional. Display this help.\nArgument: text - String. Required. Text to replace.\nArgument: replace - String. Optional. Replacement string for newlines. Default is `␤`\nWithout arguments, displays help.\nstdout: The text with the newline replaced with another character, suitable typically for single-line output\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="181"
stdout=$'The text with the newline replaced with another character, suitable typically for single-line output\n'
summary="Replace newlines in text with a replacement token for single-line output"
summaryComputed=""
usage="stringHideNewlines [ --help ] text [ replace ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringHideNewlines'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ replace ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext     '$'\e''[[(value)]mString. Required. Text to replace.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mreplace  '$'\e''[[(value)]mString. Optional. Replacement string for newlines. Default is '$'\e''[[(code)]m␤'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Hide newlines in text (to ensure single-line output or other manipulation)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''The text with the newline replaced with another character, suitable typically for single-line output'
# shellcheck disable=SC2016
helpPlain='Usage: stringHideNewlines [ --help ] text [ replace ]'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    text     String. Required. Text to replace.'$'\n''    replace  String. Optional. Replacement string for newlines. Default is ␤'$'\n'''$'\n''Hide newlines in text (to ensure single-line output or other manipulation)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''The text with the newline replaced with another character, suitable typically for single-line output'
documentationPath="documentation/source/tools/text.md"
