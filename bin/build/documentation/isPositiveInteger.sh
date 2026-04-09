#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'""
file="bin/build/tools/type.sh"
fn="isPositiveInteger"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="153"
lowerFn="ispositiveinteger"
rawComment="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Argument: value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'"Requires: catchArgument isUnsignedInteger bashDocumentation __help"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger bashDocumentation __help"$'\n'""
return_code="0 - if it is a positive integer"$'\n'"1 - if it is not a positive integer"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="36a33330145335895a980b5846e9badfaab6d726"
sourceLine="153"
summary="Test if an argument is a positive integer (non-zero)"
summaryComputed="true"
usage="isPositiveInteger value [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPositiveInteger'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvalue   '$'\e''[[(value)]mEmptyString. Required. Value to check if it is an unsigned integer'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is a positive integer'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not a positive integer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isPositiveInteger value [ --help ]'$'\n'''$'\n''    value   EmptyString. Required. Value to check if it is an unsigned integer'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is a positive integer'$'\n''- 1 - if it is not a positive integer'$'\n'''
documentationPath="documentation/source/tools/type.md"
