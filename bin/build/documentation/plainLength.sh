#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input."$'\n'""
base="text.sh"
description="Length of an unformatted string"$'\n'""
file="bin/build/tools/text.sh"
fn="plainLength"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="A file to determine the plain-text length"$'\n'""
stdout="\`UnsignedInteger\`. Length of the plain characters in the input arguments."$'\n'""
summary="Length of an unformatted string"
usage="plainLength [ text ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mplainLength[0m [94m[ text ][0m

    [94mtext  [1;97mEmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.[0m

Length of an unformatted string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
A file to determine the plain-text length

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mUnsignedInteger[0m. Length of the plain characters in the input arguments.
'
# shellcheck disable=SC2016
helpPlain='Usage: plainLength [ text ]

    text  EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.

Length of an unformatted string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
A file to determine the plain-text length

Writes to stdout:
UnsignedInteger. Length of the plain characters in the input arguments.
'
