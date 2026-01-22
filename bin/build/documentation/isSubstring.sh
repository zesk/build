#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required. Thing to search for, not blank."$'\n'"haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'""$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="isSubstring"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
summary="Check if one string is a substring of another set"
tested="No"$'\n'""
usage="isSubstring needle [ haystack ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misSubstring[0m [38;2;255;255;0m[35;48;2;0;0;0mneedle[0m[0m [94m[ haystack ... ][0m

    [31mneedle        [1;97mString. Required. Thing to search for, not blank.[0m
    [94mhaystack ...  [1;97mEmptyString. Optional. One or more array elements to match[0m

Check if one string is a substring of another set of strings (case-sensitive)

Return Code: 0 - If element is a substring of any haystack
Return Code: 1 - If element is NOT found as a substring of any haystack

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isSubstring needle [ haystack ... ]

    needle        String. Required. Thing to search for, not blank.
    haystack ...  EmptyString. Optional. One or more array elements to match

Check if one string is a substring of another set of strings (case-sensitive)

Return Code: 0 - If element is a substring of any haystack
Return Code: 1 - If element is NOT found as a substring of any haystack

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
