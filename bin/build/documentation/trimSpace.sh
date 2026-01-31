#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Trim spaces and only spaces from arguments or a pipe"$'\n'"Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs trimmed lines"$'\n'"Example:     {fn} \"\$token\""$'\n'"Example:     grep \"\$tokenPattern\" | trimSpace > \"\$tokensFound\""$'\n'"Summary: Trim whitespace of a bash argument"$'\n'"Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'"Credits: Chris F.A. Johnson (2008)"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Trim spaces and only spaces from arguments or a pipe"$'\n'"Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs trimmed lines"$'\n'"Example:     {fn} \"\$token\""$'\n'"Example:     grep \"\$tokenPattern\" | trimSpace > \"\$tokensFound\""$'\n'"Summary: Trim whitespace of a bash argument"$'\n'"Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'"Credits: Chris F.A. Johnson (2008)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Trim spaces and only spaces from arguments or a pipe"
usage="trimSpace"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtrimSpace'$'\e''[0m'$'\n'''$'\n''Trim spaces and only spaces from arguments or a pipe'$'\n''Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.'$'\n''stdin: Reads lines from stdin until EOF'$'\n''stdout: Outputs trimmed lines'$'\n''Example:     trimSpace "$token"'$'\n''Example:     grep "$tokenPattern" | trimSpace > "$tokensFound"'$'\n''Summary: Trim whitespace of a bash argument'$'\n''Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816'$'\n''Credits: Chris F.A. Johnson (2008)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: trimSpace'$'\n'''$'\n''Trim spaces and only spaces from arguments or a pipe'$'\n''Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.'$'\n''stdin: Reads lines from stdin until EOF'$'\n''stdout: Outputs trimmed lines'$'\n''Example:     trimSpace "$token"'$'\n''Example:     grep "$tokenPattern" | trimSpace > "$tokensFound"'$'\n''Summary: Trim whitespace of a bash argument'$'\n''Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816'$'\n''Credits: Chris F.A. Johnson (2008)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.522
