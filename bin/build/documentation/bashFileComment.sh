#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'source - File. Required. File where the function is defined.\nlineNumber - String. Required. Previously computed line number of the function.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extract a bash comment from a file. Excludes lines containing the following tokens:\n\n'
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashFileComment"
fnMarker="bashfilecomment"
foundNames=([0]="argument" [1]="requires")
line="501"
rawComment=$'Extract a bash comment from a file. Excludes lines containing the following tokens:\nArgument: source - File. Required. File where the function is defined.\nArgument: lineNumber - String. Required. Previously computed line number of the function.\nArgument: --help - Flag. Optional. Display this help.\nRequires: head bashFinalComment\nRequires: helpArgument bashDocumentation\n\n'
requires=$'head bashFinalComment\nhelpArgument bashDocumentation\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="501"
summary="Extract a bash comment from a file. Excludes lines containing"
summaryComputed="true"
usage="bashFileComment source lineNumber [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFileComment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlineNumber'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource      '$'\e''[[(value)]mFile. Required. File where the function is defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlineNumber  '$'\e''[[(value)]mString. Required. Previously computed line number of the function.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFileComment source lineNumber [ --help ]'$'\n'''$'\n''    source      File. Required. File where the function is defined.'$'\n''    lineNumber  String. Required. Previously computed line number of the function.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Extract a bash comment from a file. Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
