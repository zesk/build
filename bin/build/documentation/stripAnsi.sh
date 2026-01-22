#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="None."$'\n'""
base="text.sh"
credits="commandlinefu tripleee"$'\n'""
depends="sed"$'\n'""
description="Strip ANSI console escape sequences from a file"$'\n'"Write Environment: None."$'\n'"Short description: Remove ANSI escape codes from streams"$'\n'""
environment="None."$'\n'""
file="bin/build/tools/text.sh"
fn="stripAnsi"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="arbitrary text which may contain ANSI escape sequences for the terminal"$'\n'""
stdout="the same text with those ANSI escape sequences removed"$'\n'""
summary="Strip ANSI console escape sequences from a file"
usage="stripAnsi [ None. ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mstripAnsi[0m [94m[ None. ][0m

    [94mNone.  [1;97mNone.[0m

Strip ANSI console escape sequences from a file
Write Environment: None.
Short description: Remove ANSI escape codes from streams

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- None.
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
arbitrary text which may contain ANSI escape sequences for the terminal

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
the same text with those ANSI escape sequences removed
'
# shellcheck disable=SC2016
helpPlain='Usage: stripAnsi [ None. ]

    None.  None.

Strip ANSI console escape sequences from a file
Write Environment: None.
Short description: Remove ANSI escape codes from streams

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- None.
- 

Reads from stdin:
arbitrary text which may contain ANSI escape sequences for the terminal

Writes to stdout:
the same text with those ANSI escape sequences removed
'
