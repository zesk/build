#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="globalName - EnvironmentVariable. Required. Global to change temporarily to a value."$'\n'"value - EmptyString. Optional. Force the value of \`globalName\` to this value temporarily. Saves the original value."$'\n'"... - Continue passing pairs of globalName value to mock additional values."$'\n'""
base="test.sh"
description="Fake a value for testing"$'\n'""
file="bin/build/tools/test.sh"
foundNames=([0]="argument")
rawComment="Fake a value for testing"$'\n'"Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value."$'\n'"Argument: value - EmptyString. Optional. Force the value of \`globalName\` to this value temporarily. Saves the original value."$'\n'"Argument: ... - Continue passing pairs of globalName value to mock additional values."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="c65b326bd9c53bff28df0d6b559128726394401b"
summary="Fake a value for testing"
summaryComputed="true"
usage="mockEnvironmentStart globalName [ value ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmockEnvironmentStart'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mglobalName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mglobalName  '$'\e''[[(value)]mEnvironmentVariable. Required. Global to change temporarily to a value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue       '$'\e''[[(value)]mEmptyString. Optional. Force the value of '$'\e''[[(code)]mglobalName'$'\e''[[(reset)]m to this value temporarily. Saves the original value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...         '$'\e''[[(value)]mContinue passing pairs of globalName value to mock additional values.'$'\e''[[(reset)]m'$'\n'''$'\n''Fake a value for testing'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: mockEnvironmentStart [[(bold)]mglobalName [[(blue)]m[ value ] [[(blue)]m[ ... ]'$'\n'''$'\n''    [[(red)]mglobalName  [[(value)]mEnvironmentVariable. Required. Global to change temporarily to a value.'$'\n''    [[(blue)]mvalue       [[(value)]mEmptyString. Optional. Force the value of globalName to this value temporarily. Saves the original value.'$'\n''    [[(blue)]m...         [[(value)]mContinue passing pairs of globalName value to mock additional values.'$'\n'''$'\n''Fake a value for testing'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
