#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Strip ANSI console escape sequences from a file"$'\n'"Argument: None."$'\n'"Environment: None."$'\n'"Write Environment: None."$'\n'"Credits: commandlinefu tripleee"$'\n'"Short description: Remove ANSI escape codes from streams"$'\n'"Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc"$'\n'"Depends: sed"$'\n'"stdin: arbitrary text which may contain ANSI escape sequences for the terminal"$'\n'"stdout: the same text with those ANSI escape sequences removed"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Strip ANSI console escape sequences from a file"$'\n'"Argument: None."$'\n'"Environment: None."$'\n'"Write Environment: None."$'\n'"Credits: commandlinefu tripleee"$'\n'"Short description: Remove ANSI escape codes from streams"$'\n'"Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc"$'\n'"Depends: sed"$'\n'"stdin: arbitrary text which may contain ANSI escape sequences for the terminal"$'\n'"stdout: the same text with those ANSI escape sequences removed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Strip ANSI console escape sequences from a file"
usage="consoleToPlain"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleToPlain'$'\e''[0m'$'\n'''$'\n''Strip ANSI console escape sequences from a file'$'\n''Argument: None.'$'\n''Environment: None.'$'\n''Write Environment: None.'$'\n''Credits: commandlinefu tripleee'$'\n''Short description: Remove ANSI escape codes from streams'$'\n''Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc'$'\n''Depends: sed'$'\n''stdin: arbitrary text which may contain ANSI escape sequences for the terminal'$'\n''stdout: the same text with those ANSI escape sequences removed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleToPlain'$'\n'''$'\n''Strip ANSI console escape sequences from a file'$'\n''Argument: None.'$'\n''Environment: None.'$'\n''Write Environment: None.'$'\n''Credits: commandlinefu tripleee'$'\n''Short description: Remove ANSI escape codes from streams'$'\n''Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc'$'\n''Depends: sed'$'\n''stdin: arbitrary text which may contain ANSI escape sequences for the terminal'$'\n''stdout: the same text with those ANSI escape sequences removed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
