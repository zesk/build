#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'""
base="text.sh"
description="Trim spaces and only spaces from the right side of a string passed as arguments or a pipe"$'\n'""
example="    textTrimRight \"\$token\""$'\n'"    grep \"\$tokenPattern\" | textTrimRight > \"\$tokensFound\""$'\n'""
file="bin/build/tools/text.sh"
fn="textTrimRight"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="example" [4]="summary")
line="295"
lowerFn="texttrimright"
rawComment="Trim spaces and only spaces from the right side of a string passed as arguments or a pipe"$'\n'"Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs trimmed lines"$'\n'"Example:     {fn} \"\$token\""$'\n'"Example:     grep \"\$tokenPattern\" | {fn} > \"\$tokensFound\""$'\n'"Summary: Trim whitespace of a bash argument"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
sourceLine="295"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs trimmed lines"$'\n'""
summary="Trim whitespace of a bash argument"$'\n'""
usage="textTrimRight [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextTrimRight'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtext  '$'\e''[[(value)]mEmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.'$'\e''[[(reset)]m'$'\n'''$'\n''Trim spaces and only spaces from the right side of a string passed as arguments or a pipe'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs trimmed lines'$'\n'''$'\n''Example:'$'\n''    textTrimRight "$token"'$'\n''    grep "$tokenPattern" | textTrimRight > "$tokensFound"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textTrimRight [ text ]'$'\n'''$'\n''    text  EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.'$'\n'''$'\n''Trim spaces and only spaces from the right side of a string passed as arguments or a pipe'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs trimmed lines'$'\n'''$'\n''Example:'$'\n''    textTrimRight "$token"'$'\n''    grep "$tokenPattern" | textTrimRight > "$tokensFound"'$'\n'''
documentationPath="documentation/source/tools/text.md"
