#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'path ... - File. Required. One or more paths to simplify\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Normalizes segments of `/./` and `/../` in a path without using `fileRealPath`\nRemoves dot and dot-dot paths from a path correctly\n\n'
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="directoryPathSimplify"
fnMarker="directorypathsimplify"
foundNames=([0]="argument")
line="464"
rawComment=$'Argument: path ... - File. Required. One or more paths to simplify\nNormalizes segments of `/./` and `/../` in a path without using `fileRealPath`\nRemoves dot and dot-dot paths from a path correctly\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="c688f25ccc836a3de5e08fcee0b11da564d05e7a"
sourceLine="464"
summary="Normalizes segments of \`/./\` and \`/../\` in a path without"
summaryComputed="true"
usage="directoryPathSimplify path ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryPathSimplify'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mpath ...  '$'\e''[[(value)]mFile. Required. One or more paths to simplify'$'\e''[[(reset)]m'$'\n'''$'\n''Normalizes segments of '$'\e''[[(code)]m/./'$'\e''[[(reset)]m and '$'\e''[[(code)]m/../'$'\e''[[(reset)]m in a path without using '$'\e''[[(code)]mfileRealPath'$'\e''[[(reset)]m'$'\n''Removes dot and dot-dot paths from a path correctly'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: directoryPathSimplify path ...'$'\n'''$'\n''    path ...  File. Required. One or more paths to simplify'$'\n'''$'\n''Normalizes segments of /./ and /../ in a path without using fileRealPath'$'\n''Removes dot and dot-dot paths from a path correctly'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/directory.md"
