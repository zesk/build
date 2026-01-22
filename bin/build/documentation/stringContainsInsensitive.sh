#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="haystack - String. Required. String to search."$'\n'"needle ... - String. Optional. One or more strings to find as a case-insensitive substring of \`haystack\`."$'\n'""
base="text.sh"
description="Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Does needle exist as a substring of haystack?"$'\n'""
file="bin/build/tools/text.sh"
fn="stringContainsInsensitive"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
summary="Find whether a substring exists in one or more strings"$'\n'""
usage="stringContainsInsensitive haystack [ needle ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mstringContainsInsensitive[0m [38;2;255;255;0m[35;48;2;0;0;0mhaystack[0m[0m [94m[ needle ... ][0m

    [31mhaystack    [1;97mString. Required. String to search.[0m
    [94mneedle ...  [1;97mString. Optional. One or more strings to find as a case-insensitive substring of [38;2;0;255;0;48;2;0;0;0mhaystack[0m.[0m

Return Code: 0 - IFF ANY needle matches as a substring of haystack
Return Code: 1 - No needles found in haystack
Does needle exist as a substring of haystack?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: stringContainsInsensitive haystack [ needle ... ]

    haystack    String. Required. String to search.
    needle ...  String. Optional. One or more strings to find as a case-insensitive substring of haystack.

Return Code: 0 - IFF ANY needle matches as a substring of haystack
Return Code: 1 - No needles found in haystack
Does needle exist as a substring of haystack?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
