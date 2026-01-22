#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/example.sh"
argument="value - EmptyString. Value to test if it is an unsigned integer."$'\n'""
base="example.sh"
credits="F. Hauri - Give Up GitHub (isnum_Case)"$'\n'""
description="Test if a value is a 0 or greater integer. Leading \"+\" is ok."$'\n'"Return Code: 0 - if it is an unsigned integer"$'\n'"Return Code: 1 - if it is not an unsigned integer"$'\n'""
file="bin/build/tools/example.sh"
fn="isUnsignedInteger"
original="is_uint"$'\n'""
requires="returnMessage"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceModified="1768721469"
summary="Is value an unsigned integer?"$'\n'""
usage="isUnsignedInteger [ value ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misUnsignedInteger[0m [94m[ value ][0m

    [94mvalue  [1;97mEmptyString. Value to test if it is an unsigned integer.[0m

Test if a value is a 0 or greater integer. Leading "+" is ok.
Return Code: 0 - if it is an unsigned integer
Return Code: 1 - if it is not an unsigned integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isUnsignedInteger [ value ]

    value  EmptyString. Value to test if it is an unsigned integer.

Test if a value is a 0 or greater integer. Leading "+" is ok.
Return Code: 0 - if it is an unsigned integer
Return Code: 1 - if it is not an unsigned integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
