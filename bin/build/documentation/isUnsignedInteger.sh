#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-19
# shellcheck disable=SC2034
argument="value - EmptyString. Value to test if it is an unsigned integer."$'\n'""
base="example.sh"
credits="F. Hauri - Give Up GitHub (isnum_Case)"$'\n'""
description="Test if a value is a 0 or greater integer. Leading \"+\" is ok."$'\n'""
file="bin/build/tools/example.sh"
fn="isUnsignedInteger"
foundNames=([0]="summary" [1]="source" [2]="credits" [3]="original" [4]="argument" [5]="return_code" [6]="requires")
original="is_uint"$'\n'""
rawComment="Summary: Is value an unsigned integer?"$'\n'"Test if a value is a 0 or greater integer. Leading \"+\" is ok."$'\n'"Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'"Credits: F. Hauri - Give Up GitHub (isnum_Case)"$'\n'"Original: is_uint"$'\n'"Argument: value - EmptyString. Value to test if it is an unsigned integer."$'\n'"Return Code: 0 - if it is an unsigned integer"$'\n'"Return Code: 1 - if it is not an unsigned integer"$'\n'"Requires: returnMessage"$'\n'""$'\n'""
requires="returnMessage"$'\n'""
return_code="0 - if it is an unsigned integer"$'\n'"1 - if it is not an unsigned integer"$'\n'""
source="https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceHash="9e4e0b6459728fe22941b831964230f2c77fa1de"
summary="Is value an unsigned integer?"$'\n'""
usage="isUnsignedInteger [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misUnsignedInteger'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mvalue  '$'\e''[[(value)]mEmptyString. Value to test if it is an unsigned integer.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if a value is a 0 or greater integer. Leading "+" is ok.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is an unsigned integer'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not an unsigned integer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isUnsignedInteger [ value ]'$'\n'''$'\n''    value  EmptyString. Value to test if it is an unsigned integer.'$'\n'''$'\n''Test if a value is a 0 or greater integer. Leading "+" is ok.'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is an unsigned integer'$'\n''- 1 - if it is not an unsigned integer'$'\n'''
