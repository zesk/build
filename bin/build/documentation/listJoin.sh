#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"text0 ... - String. Optional. One or more strings to join"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Output a list of items joined by a character"$'\n'""
file="bin/build/tools/list.sh"
fn="listJoin"
foundNames=([0]="output" [1]="argument")
line="23"
lowerFn="listjoin"
output="text"$'\n'""
rawComment="Output a list of items joined by a character"$'\n'"Output: text"$'\n'"Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"Argument: text0 ... - String. Optional. One or more strings to join"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="41d98a302feb190799f47d4570b57b5beb5b3303"
sourceLine="23"
summary="Output a list of items joined by a character"
summaryComputed="true"
usage="listJoin separator [ text0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistJoin'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text0 ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mEmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext0 ...  '$'\e''[[(value)]mString. Optional. One or more strings to join'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a list of items joined by a character'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listJoin separator [ text0 ... ] [ --help ]'$'\n'''$'\n''    separator  EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.'$'\n''    text0 ...  String. Optional. One or more strings to join'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Output a list of items joined by a character'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/list.md"
