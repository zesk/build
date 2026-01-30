#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="encodedValue - String. Required. Value to convert to tokens, one per line"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
description="Convert an array value which was loaded already"$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="Convert an array value which was loaded already"$'\n'"Argument: encodedValue - String. Required. Value to convert to tokens, one per line"$'\n'"stdout: Array values separated by newlines"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="3af1fd933e859692ce77e0ffdcfdcef6ad09e283"
stdout="Array values separated by newlines"$'\n'""
summary="Convert an array value which was loaded already"
usage="environmentValueConvertArray encodedValue [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueConvertArray'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mencodedValue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mencodedValue  '$'\e''[[(value)]mString. Required. Value to convert to tokens, one per line'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Convert an array value which was loaded already'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Array values separated by newlines'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]menvironmentValueConvertArray [[(bold)]m[[(magenta)]mencodedValue [[(blue)]m[ --help ]'$'\n'''$'\n''    encodedValue  [[(value)]mString. Required. Value to convert to tokens, one per line'$'\n''    [[(blue)]m--help        [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Convert an array value which was loaded already'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Writes to [[(code)]mstdout:'$'\n''Array values separated by newlines'$'\n'''
# elapsed 2.686
