#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
description="Parses text and determines if it's true-ish"$'\n'""$'\n'"Return Code: 0 - true"$'\n'"Return Code: 1 - false"$'\n'"Return Code: 2 - Neither"$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""
file="bin/build/tools/text.sh"
fn="parseBoolean"
requires="lowercase __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
summary="Parses text and determines if it's true-ish"
usage="parseBoolean"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mparseBoolean[0m

Parses text and determines if it'\''s true-ish

Return Code: 0 - true
Return Code: 1 - false
Return Code: 2 - Neither
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
helpPlain='Usage: parseBoolean

Parses text and determines if it'\''s true-ish

Return Code: 0 - true
Return Code: 1 - false
Return Code: 2 - Neither
Without arguments, displays help.
Return code: - 0 - Text is plain
Return code: - 1 - Text contains non-plain characters

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
