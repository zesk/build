#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-04
# shellcheck disable=SC2034
argument="--reset - Flag. Optional. Reset statistics to zero."$'\n'"--total - Flag. Optional. Just output the total."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
description="Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline"$'\n'""
example="    read -r failures successes < <(assertStatistics) || return \$?"$'\n'""
file="bin/build/tools/test.sh"
fn="assertStatistics"
foundNames=([0]="summary" [1]="argument" [2]="stdout" [3]="example")
rawComment="Summary: Output assertion counts"$'\n'"Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline"$'\n'"Argument: --reset - Flag. Optional. Reset statistics to zero."$'\n'"Argument: --total - Flag. Optional. Just output the total."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: UnsignedInteger. 2 lines."$'\n'"Example:     read -r failures successes < <({fn}) || return \$?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="a67c5b2c2396821f4e070140f0dabed2cde8ea23"
stdout="UnsignedInteger. 2 lines."$'\n'""
summary="Output assertion counts"$'\n'""
usage="assertStatistics [ --reset ] [ --total ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]massertStatistics'$'\e''[0m '$'\e''[[(blue)]m[ --reset ]'$'\e''[0m '$'\e''[[(blue)]m[ --total ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--reset  '$'\e''[[(value)]mFlag. Optional. Reset statistics to zero.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--total  '$'\e''[[(value)]mFlag. Optional. Just output the total.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger. 2 lines.'$'\n'''$'\n''Example:'$'\n''    read -r failures successes < <(assertStatistics) || return $?'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: assertStatistics [ --reset ] [ --total ] [ --help ]'$'\n'''$'\n''    --reset  Flag. Optional. Reset statistics to zero.'$'\n''    --total  Flag. Optional. Just output the total.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger. 2 lines.'$'\n'''$'\n''Example:'$'\n''    read -r failures successes < <(assertStatistics) || return $?'$'\n'''
