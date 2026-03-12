#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'""
base="type.sh"
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'""
file="bin/build/tools/type.sh"
fn="isPositiveInteger"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Argument: value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'"Requires: catchArgument isUnsignedInteger usageDocument"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger usageDocument"$'\n'""
return_code="0 - if it is a positive integer"$'\n'"1 - if it is not a positive integer"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="c60b8f9d9123f5a6eb04a56b93a1ce09d79d8d26"
summary="Test if an argument is a positive integer (non-zero)"
summaryComputed="true"
usage="isPositiveInteger value"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPositiveInteger'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvalue  '$'\e''[[(value)]mEmptyString. Required. Value to check if it is an unsigned integer'$'\e''[[(reset)]m'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is a positive integer'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not a positive integer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isPositiveInteger value'$'\n'''$'\n''    value  EmptyString. Required. Value to check if it is an unsigned integer'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is a positive integer'$'\n''- 1 - if it is not a positive integer'$'\n'''
