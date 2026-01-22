#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="searchPattern - String. Required. The string to search for."$'\n'"replacePattern - String. Required. The replacement to replace with."$'\n'""
base="sed.sh"
description="Quote a sed command for search and replace"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/sed.sh"
fn="sedReplacePattern"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceModified="1769063211"
summary="Quote a sed command for search and replace"
usage="sedReplacePattern searchPattern replacePattern"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255msedReplacePattern[0m [38;2;255;255;0m[35;48;2;0;0;0msearchPattern[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mreplacePattern[0m[0m

    [31msearchPattern   [1;97mString. Required. The string to search for.[0m
    [31mreplacePattern  [1;97mString. Required. The replacement to replace with.[0m

Quote a sed command for search and replace
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: sedReplacePattern searchPattern replacePattern

    searchPattern   String. Required. The string to search for.
    replacePattern  String. Required. The replacement to replace with.

Quote a sed command for search and replace
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
