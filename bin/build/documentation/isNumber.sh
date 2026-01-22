#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="value - EmptyString. Required. Value to test."$'\n'""
base="type.sh"
credits="F. Hauri - Give Up GitHub (isnum_Case)"$'\n'""
description="Test if an argument is a floating point number"$'\n'"(\`1e3\` notation NOT supported)"$'\n'""$'\n'"Return Code: 0 - if it is a floating point number"$'\n'"Return Code: 1 - if it is not a floating point number"$'\n'""$'\n'""
file="bin/build/tools/type.sh"
fn="isNumber"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceModified="1768721470"
summary="Test if an argument is a floating point number"
usage="isNumber value"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misNumber[0m [38;2;255;255;0m[35;48;2;0;0;0mvalue[0m[0m

    [31mvalue  [1;97mEmptyString. Required. Value to test.[0m

Test if an argument is a floating point number
([38;2;0;255;0;48;2;0;0;0m1e3[0m notation NOT supported)

Return Code: 0 - if it is a floating point number
Return Code: 1 - if it is not a floating point number

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isNumber value

    value  EmptyString. Required. Value to test.

Test if an argument is a floating point number
(1e3 notation NOT supported)

Return Code: 0 - if it is a floating point number
Return Code: 1 - if it is not a floating point number

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
