#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
description="Outputs the maximum line length passed into stdin"$'\n'""
file="bin/build/tools/text.sh"
fn="maximumLineLength"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="Lines are read from standard in and line length is computed for each line"$'\n'""
stdout="\`UnsignedInteger\`"$'\n'""
summary="Outputs the maximum line length passed into stdin"
usage="maximumLineLength"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmaximumLineLength[0m

Outputs the maximum line length passed into stdin

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Lines are read from standard in and line length is computed for each line

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mUnsignedInteger[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: maximumLineLength

Outputs the maximum line length passed into stdin

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Lines are read from standard in and line length is computed for each line

Writes to stdout:
UnsignedInteger
'
