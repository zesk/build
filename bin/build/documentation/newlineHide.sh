#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"text - String. Required. Text to replace."$'\n'"replace - String. Optional. Replacement string for newlines."$'\n'""
base="text.sh"
description="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="newlineHide"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""
summary="Hide newlines in text (to ensure single-line output or other"
usage="newlineHide [ --help ] text [ replace ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mnewlineHide[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m [94m[ replace ][0m

    [94m--help   [1;97mFlag. Optional. Display this help.[0m
    [31mtext     [1;97mString. Required. Text to replace.[0m
    [94mreplace  [1;97mString. Optional. Replacement string for newlines.[0m

Hide newlines in text (to ensure single-line output or other manipulation)
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
The text with the newline replaced with another character, suitable typically for single-line output
'
# shellcheck disable=SC2016
helpPlain='Usage: newlineHide [ --help ] text [ replace ]

    --help   Flag. Optional. Display this help.
    text     String. Required. Text to replace.
    replace  String. Optional. Replacement string for newlines.

Hide newlines in text (to ensure single-line output or other manipulation)
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
The text with the newline replaced with another character, suitable typically for single-line output
'
