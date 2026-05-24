#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--reset - Flag. Optional. Reset statistics to zero.\n--total - Flag. Optional. Just output the total.\n--help - Flag. Optional. Display this help.\n'
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline\n\n'
descriptionLineCount="2"
example=$'    read -r failures successes < <(assertStatistics) || return $?\n'
file="bin/build/tools/test.sh"
fn="assertStatistics"
fnMarker="assertstatistics"
foundNames=([0]="summary" [1]="argument" [2]="stdout" [3]="example")
line="117"
rawComment=$'Summary: Output assertion counts\nOutput the total number of assertion failures and assertion successes, separated by a space and terminated with a newline\nArgument: --reset - Flag. Optional. Reset statistics to zero.\nArgument: --total - Flag. Optional. Just output the total.\nArgument: --help - Flag. Optional. Display this help.\nstdout: UnsignedInteger. 2 lines.\nExample:     read -r failures successes < <({fn}) || return $?\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="117"
stdout=$'UnsignedInteger. 2 lines.\n'
summary="Output assertion counts"
summaryComputed=""
usage="assertStatistics [ --reset ] [ --total ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]massertStatistics'$'\e''[0m '$'\e''[[(blue)]m[ --reset ]'$'\e''[0m '$'\e''[[(blue)]m[ --total ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--reset  '$'\e''[[(value)]mFlag. Optional. Reset statistics to zero.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--total  '$'\e''[[(value)]mFlag. Optional. Just output the total.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger. 2 lines.'$'\n'''$'\n''Example:'$'\n''    read -r failures successes < <(assertStatistics) || return $?'
# shellcheck disable=SC2016
helpPlain='Usage: assertStatistics [ --reset ] [ --total ] [ --help ]'$'\n'''$'\n''    --reset  Flag. Optional. Reset statistics to zero.'$'\n''    --total  Flag. Optional. Just output the total.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger. 2 lines.'$'\n'''$'\n''Example:'$'\n''    read -r failures successes < <(assertStatistics) || return $?'
documentationPath="documentation/source/tools/test.md"
