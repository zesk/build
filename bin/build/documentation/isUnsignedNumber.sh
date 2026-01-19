#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-19
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="value - EmptyString. Required. Value to test."$'\n'""
base="type.sh"
credits="F. Hauri - Give Up GitHub (isnum_Case)"$'\n'""
description="Test if an argument is a positive floating point number"$'\n'"(\`1e3\` notation NOT supported)"$'\n'""$'\n'"Return Code: 0 - if it is a number equal to or greater than zero"$'\n'"Return Code: 1 - if it is not a number equal to or greater than zero"$'\n'""$'\n'""
file="bin/build/tools/type.sh"
fn="isUnsignedNumber"
foundNames=([0]="argument" [1]="credits" [2]="source")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""
sourceModified="1768721470"
summary="Test if an argument is a positive floating point number"
usage="isUnsignedNumber value"
