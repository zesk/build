#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-05
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"lineNumber - String. Required. Previously computed line number of the function."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFileComment"
foundNames=([0]="argument" [1]="requires")
rawComment="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: lineNumber - String. Required. Previously computed line number of the function."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: head bashFinalComment"$'\n'"Requires: __help bashDocumentation"$'\n'""$'\n'""
requires="head bashFinalComment"$'\n'"__help bashDocumentation"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="286d8187414ff4bf8505a905b49ba4ca2b627ae9"
summary="Extract a bash comment from a file. Excludes lines containing"
summaryComputed="true"
usage="bashFileComment source lineNumber [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFileComment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlineNumber'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource      '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlineNumber  '$'\e''[[(value)]mString. Required. Previously computed line number of the function.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFileComment source lineNumber [ --help ]'$'\n'''$'\n''    source      File. Required. File where the function is defined.'$'\n''    lineNumber  String. Required. Previously computed line number of the function.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
