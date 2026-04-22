#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="value - EmptyString. Required. Value to test."$'\n'""
base="type.sh"
credits="F. Hauri - Give Up GitHub (isnum_Case)"$'\n'""
description="Test if an argument is a positive floating point number"$'\n'"(\`1e3\` notation NOT supported)"$'\n'""
file="bin/build/tools/type.sh"
fn="isUnsignedNumber"
foundNames=([0]="argument" [1]="return_code" [2]="credits" [3]="source")
line="30"
lowerFn="isunsignednumber"
rawComment="Test if an argument is a positive floating point number"$'\n'"(\`1e3\` notation NOT supported)"$'\n'"Argument: value - EmptyString. Required. Value to test."$'\n'"Return Code: 0 - if it is a number equal to or greater than zero"$'\n'"Return Code: 1 - if it is not a number equal to or greater than zero"$'\n'"Credits: F. Hauri - Give Up GitHub (isnum_Case)"$'\n'"Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""$'\n'""
return_code="0 - if it is a number equal to or greater than zero"$'\n'"1 - if it is not a number equal to or greater than zero"$'\n'""
source="https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="30"
summary="Test if an argument is a positive floating point number"
summaryComputed="true"
usage="isUnsignedNumber value"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misUnsignedNumber'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvalue  '$'\e''[[(value)]mEmptyString. Required. Value to test.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if an argument is a positive floating point number'$'\n''('$'\e''[[(code)]m1e3'$'\e''[[(reset)]m notation NOT supported)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is a number equal to or greater than zero'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not a number equal to or greater than zero'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isUnsignedNumber value'$'\n'''$'\n''    value  EmptyString. Required. Value to test.'$'\n'''$'\n''Test if an argument is a positive floating point number'$'\n''(1e3 notation NOT supported)'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is a number equal to or greater than zero'$'\n''- 1 - if it is not a number equal to or greater than zero'$'\n'''
documentationPath="documentation/source/tools/type.md"
