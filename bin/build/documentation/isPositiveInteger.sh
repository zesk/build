#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/type.sh"
fn="isPositiveInteger"
fnMarker="ispositiveinteger"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="153"
original="isPositiveInteger"
rawComment="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Argument: value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'"Requires: catchArgument isUnsignedInteger bashDocumentation helpArgument"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger bashDocumentation helpArgument"$'\n'""
return_code="0 - if it is a positive integer"$'\n'"1 - if it is not a positive integer"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="a44ecefca78b37437c11852fd5a4111cdbe0d376"
sourceLine="153"
summary="Test if an argument is a positive integer (non-zero)"
summaryComputed="true"
usage="isPositiveInteger value [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPositiveInteger'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvalue   '$'\e''[[(value)]mEmptyString. Required. Value to check if it is an unsigned integer'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is a positive integer'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not a positive integer'
# shellcheck disable=SC2016
helpPlain='Usage: isPositiveInteger value [ --help ]'$'\n'''$'\n''    value   EmptyString. Required. Value to check if it is an unsigned integer'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is a positive integer'$'\n''- 1 - if it is not a positive integer'
documentationPath="documentation/source/tools/type.md"
