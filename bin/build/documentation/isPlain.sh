#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - String. Required. Text to search for mapping tokens."$'\n'""
base="text.sh"
description="Check if text contains plaintext only."$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""
file="bin/build/tools/text.sh"
fn="isPlain"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
summary="Check if text contains plaintext only."
usage="isPlain text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misPlain[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [31mtext  [1;97mString. Required. Text to search for mapping tokens.[0m

Check if text contains plaintext only.
Without arguments, displays help.
Return code: - [38;2;0;255;0;48;2;0;0;0m0[0m - Text is plain
Return code: - [38;2;0;255;0;48;2;0;0;0m1[0m - Text contains non-plain characters

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isPlain text

    text  String. Required. Text to search for mapping tokens.

Check if text contains plaintext only.
Without arguments, displays help.
Return code: - 0 - Text is plain
Return code: - 1 - Text contains non-plain characters

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
