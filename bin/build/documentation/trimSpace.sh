#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'""
base="text.sh"
credits="Chris F.A. Johnson (2008)"$'\n'""
description="Trim spaces and only spaces from arguments or a pipe"$'\n'""
example="    trimSpace \"\$token\""$'\n'"    grep \"\$tokenPattern\" | trimSpace > \"\$tokensFound\""$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="example" [4]="summary" [5]="source" [6]="credits")
rawComment="Trim spaces and only spaces from arguments or a pipe"$'\n'"Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs trimmed lines"$'\n'"Example:     {fn} \"\$token\""$'\n'"Example:     grep \"\$tokenPattern\" | trimSpace > \"\$tokensFound\""$'\n'"Summary: Trim whitespace of a bash argument"$'\n'"Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'"Credits: Chris F.A. Johnson (2008)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'""
sourceModified="1769226342"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs trimmed lines"$'\n'""
summary="Trim whitespace of a bash argument"$'\n'""
usage="trimSpace [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mtrimSpace'$'\e''[0m '$'\e''[[blue]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mtext  '$'\e''[[value]mEmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.'$'\e''[[reset]m'$'\n'''$'\n''Trim spaces and only spaces from arguments or a pipe'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''Outputs trimmed lines'$'\n'''$'\n''Example:'$'\n''    trimSpace "$token"'$'\n''    grep "$tokenPattern" | trimSpace > "$tokensFound"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: trimSpace [ text ]'$'\n'''$'\n''    text  EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.'$'\n'''$'\n''Trim spaces and only spaces from arguments or a pipe'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs trimmed lines'$'\n'''$'\n''Example:'$'\n''    trimSpace "$token"'$'\n''    grep "$tokenPattern" | trimSpace > "$tokensFound"'$'\n'''
