#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'directory - Directory. Required. Directory to search for the newest file.\n--find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Find the newest modified file in a directory\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="directoryNewestFile"
fnMarker="directorynewestfile"
foundNames=([0]="argument")
line="718"
rawComment=$'Find the newest modified file in a directory\nArgument: directory - Directory. Required. Directory to search for the newest file.\nArgument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="718"
summary="Find the newest modified file in a directory"
summaryComputed="true"
usage="directoryNewestFile directory [ --find findArgs ... -- ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryNewestFile'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --find findArgs ... -- ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory               '$'\e''[[(value)]mDirectory. Required. Directory to search for the newest file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--find findArgs ... --  '$'\e''[[(value)]mArguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\e''[[(reset)]m'$'\n'''$'\n''Find the newest modified file in a directory'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: directoryNewestFile directory [ --find findArgs ... -- ]'$'\n'''$'\n''    directory               Directory. Required. Directory to search for the newest file.'$'\n''    --find findArgs ... --  Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)'$'\n'''$'\n''Find the newest modified file in a directory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/directory.md"
