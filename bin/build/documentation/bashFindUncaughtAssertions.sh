#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--exclude path - String. Optional. Exclude paths which contain this string\n--exec binary - Executable. Optional. For each failed file run this command.\ndirectory - Directory. Optional. Where to search for files to check.\n--list - Flag. Optional. List files which fail. (Default is simply to exit silently.)\n'
base="lint.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Search bash files for assertions which do not terminate a function and are likely an error\n\n'
descriptionLineCount="2"
file="bin/build/tools/lint.sh"
fn="bashFindUncaughtAssertions"
fnMarker="bashfinduncaughtassertions"
foundNames=([0]="argument")
line="289"
rawComment=$'Search bash files for assertions which do not terminate a function and are likely an error\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --exclude path - String. Optional. Exclude paths which contain this string\nArgument: --exec binary - Executable. Optional. For each failed file run this command.\nArgument: directory - Directory. Optional. Where to search for files to check.\nArgument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/lint.sh"
sourceHash="a8b2d492a178af746e06876c16f2fad5052a9650"
sourceLine="289"
summary="Search bash files for assertions which do not terminate a"
summaryComputed="true"
usage="bashFindUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFindUncaughtAssertions'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --exclude path ]'$'\e''[0m '$'\e''[[(blue)]m[ --exec binary ]'$'\e''[0m '$'\e''[[(blue)]m[ directory ]'$'\e''[0m '$'\e''[[(blue)]m[ --list ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--exclude path     '$'\e''[[(value)]mString. Optional. Exclude paths which contain this string'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--exec binary      '$'\e''[[(value)]mExecutable. Optional. For each failed file run this command.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdirectory          '$'\e''[[(value)]mDirectory. Optional. Where to search for files to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--list             '$'\e''[[(value)]mFlag. Optional. List files which fail. (Default is simply to exit silently.)'$'\e''[[(reset)]m'$'\n'''$'\n''Search bash files for assertions which do not terminate a function and are likely an error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFindUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --exclude path     String. Optional. Exclude paths which contain this string'$'\n''    --exec binary      Executable. Optional. For each failed file run this command.'$'\n''    directory          Directory. Optional. Where to search for files to check.'$'\n''    --list             Flag. Optional. List files which fail. (Default is simply to exit silently.)'$'\n'''$'\n''Search bash files for assertions which do not terminate a function and are likely an error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/test.md"
