#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'""
base="type.sh"
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'""
file="bin/build/tools/type.sh"
fn="isPositiveInteger"
requires="catchArgument isUnsignedInteger usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceModified="1768721470"
summary="Test if an argument is a positive integer (non-zero)"
usage="isPositiveInteger value"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misPositiveInteger[0m [38;2;255;255;0m[35;48;2;0;0;0mvalue[0m[0m

    [31mvalue  [1;97mEmptyString. Required. Value to check if it is an unsigned integer[0m

Test if an argument is a positive integer (non-zero)
Takes one argument only.
Return Code: 0 - if it is a positive integer
Return Code: 1 - if it is not a positive integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isPositiveInteger value

    value  EmptyString. Required. Value to check if it is an unsigned integer

Test if an argument is a positive integer (non-zero)
Takes one argument only.
Return Code: 0 - if it is a positive integer
Return Code: 1 - if it is not a positive integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
