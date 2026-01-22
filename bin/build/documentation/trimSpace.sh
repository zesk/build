#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'""
base="text.sh"
credits="Chris F.A. Johnson (2008)"$'\n'""
description="Trim spaces and only spaces from arguments or a pipe"$'\n'""
example="    trimSpace \"\$token\""$'\n'"    grep \"\$tokenPattern\" | trimSpace > \"\$tokensFound\""$'\n'""
file="bin/build/tools/text.sh"
fn="trimSpace"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs trimmed lines"$'\n'""
summary="Trim whitespace of a bash argument"$'\n'""
usage="trimSpace [ text ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtrimSpace[0m [94m[ text ][0m

    [94mtext  [1;97mEmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.[0m

Trim spaces and only spaces from arguments or a pipe

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Reads lines from stdin until EOF

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Outputs trimmed lines

Example:
    trimSpace "$token"
    grep "$tokenPattern" | trimSpace > "$tokensFound"
'
# shellcheck disable=SC2016
helpPlain='Usage: trimSpace [ text ]

    text  EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.

Trim spaces and only spaces from arguments or a pipe

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Reads lines from stdin until EOF

Writes to stdout:
Outputs trimmed lines

Example:
    trimSpace "$token"
    grep "$tokenPattern" | trimSpace > "$tokensFound"
'
