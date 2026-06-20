#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value ... - EmptyString. One or more values to test."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="True-ish"$'\n'"Succeeds when all arguments are \"true\"-ish"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/type.sh"
fn="isTrue"
fnMarker="istrue"
foundNames=([0]="argument")
line="72"
original="isTrue"
rawComment="True-ish"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value ... - EmptyString. One or more values to test."$'\n'"Succeeds when all arguments are \"true\"-ish"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="a44ecefca78b37437c11852fd5a4111cdbe0d376"
sourceLine="72"
summary="True-ish"
summaryComputed="true"
usage="isTrue [ --help ] [ value ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misTrue'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ value ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue ...  '$'\e''[[(value)]mEmptyString. One or more values to test.'$'\e''[[(reset)]m'$'\n'''$'\n''True-ish'$'\n''Succeeds when all arguments are "true"-ish'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: isTrue [ --help ] [ value ... ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    value ...  EmptyString. One or more values to test.'$'\n'''$'\n''True-ish'$'\n''Succeeds when all arguments are "true"-ish'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/type.md"
