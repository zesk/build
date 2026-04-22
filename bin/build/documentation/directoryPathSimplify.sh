#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="path ... - File. Required. One or more paths to simplify"$'\n'""
base="file.sh"
description="Normalizes segments of \`/./\` and \`/../\` in a path without using \`fileRealPath\`"$'\n'"Removes dot and dot-dot paths from a path correctly"$'\n'""
file="bin/build/tools/file.sh"
fn="directoryPathSimplify"
foundNames=([0]="argument")
line="327"
lowerFn="directorypathsimplify"
rawComment="Argument: path ... - File. Required. One or more paths to simplify"$'\n'"Normalizes segments of \`/./\` and \`/../\` in a path without using \`fileRealPath\`"$'\n'"Removes dot and dot-dot paths from a path correctly"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="7e7132935e7a4026938b5792385f9b35d7bd4f35"
sourceLine="327"
summary="Normalizes segments of \`/./\` and \`/../\` in a path without"
summaryComputed="true"
usage="directoryPathSimplify path ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryPathSimplify'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mpath ...  '$'\e''[[(value)]mFile. Required. One or more paths to simplify'$'\e''[[(reset)]m'$'\n'''$'\n''Normalizes segments of '$'\e''[[(code)]m/./'$'\e''[[(reset)]m and '$'\e''[[(code)]m/../'$'\e''[[(reset)]m in a path without using '$'\e''[[(code)]mfileRealPath'$'\e''[[(reset)]m'$'\n''Removes dot and dot-dot paths from a path correctly'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryPathSimplify path ...'$'\n'''$'\n''    path ...  File. Required. One or more paths to simplify'$'\n'''$'\n''Normalizes segments of /./ and /../ in a path without using fileRealPath'$'\n''Removes dot and dot-dot paths from a path correctly'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/directory.md"
