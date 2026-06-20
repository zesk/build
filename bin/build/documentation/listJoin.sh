#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.\ntext0 ... - String. Optional. One or more strings to join\n--help - Flag. Optional. Display this help.\n'
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a list of items joined by a character\n\n'
descriptionLineCount="2"
file="bin/build/tools/list.sh"
fn="listJoin"
fnMarker="listjoin"
foundNames=([0]="output" [1]="argument")
line="25"
original="listJoin"
output=$'text\n'
rawComment=$'Output a list of items joined by a character\nOutput: text\nArgument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.\nArgument: text0 ... - String. Optional. One or more strings to join\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/list.sh"
sourceHash="1179b5a538eb132a6b38a5c32bf461f3f9ad5f78"
sourceLine="25"
summary="Output a list of items joined by a character"
summaryComputed="true"
usage="listJoin separator [ text0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistJoin'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text0 ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mEmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext0 ...  '$'\e''[[(value)]mString. Optional. One or more strings to join'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a list of items joined by a character'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: listJoin separator [ text0 ... ] [ --help ]'$'\n'''$'\n''    separator  EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.'$'\n''    text0 ...  String. Optional. One or more strings to join'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Output a list of items joined by a character'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/list.md"
