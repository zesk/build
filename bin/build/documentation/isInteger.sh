#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="value - EmptyString. Required. Value to test."$'\n'"value - EmptyString. The value to test."$'\n'""
base="type.sh"
credits="F. Hauri - Give Up GitHub (isuint_Case)"$'\n'""
description="Test if an argument is a signed integer"$'\n'""
file="bin/build/tools/type.sh"
fn="isInteger"
foundNames=([0]="argument" [1]="return_code" [2]="credits" [3]="source")
rawComment="Test if an argument is a signed integer"$'\n'"Argument: value - EmptyString. Required. Value to test."$'\n'"Return Code: 0 - if it is a signed integer"$'\n'"Return Code: 1 - if it is not a signed integer"$'\n'"Argument: value - EmptyString. The value to test."$'\n'"Credits: F. Hauri - Give Up GitHub (isuint_Case)"$'\n'"Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""$'\n'""
return_code="0 - if it is a signed integer"$'\n'"1 - if it is not a signed integer"$'\n'""
source="https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="31b62907df0050b8df8d06ec27701b9721bf81aa"
summary="Test if an argument is a signed integer"
summaryComputed="true"
usage="isInteger value [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misInteger'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvalue  '$'\e''[[(value)]mEmptyString. Required. Value to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue  '$'\e''[[(value)]mEmptyString. The value to test.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if an argument is a signed integer'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is a signed integer'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not a signed integer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isInteger value [ value ]'$'\n'''$'\n''    value  EmptyString. Required. Value to test.'$'\n''    value  EmptyString. The value to test.'$'\n'''$'\n''Test if an argument is a signed integer'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is a signed integer'$'\n''- 1 - if it is not a signed integer'$'\n'''
