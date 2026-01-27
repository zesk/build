#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'""
base="platform.sh"
description="Makes all \`*.sh\` files executable"$'\n'""
environment="Works from the current directory"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=([0]="todo" [1]="argument" [2]="environment" [3]="see")
rawComment="Makes all \`*.sh\` files executable"$'\n'"TODO: - findArguments is different here than other places"$'\n'"Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'"Environment: Works from the current directory"$'\n'"See: bashMakeExecutable"$'\n'"See: chmod-sh.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashMakeExecutable"$'\n'"chmod-sh.sh"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1769184734"
summary="Makes all \`*.sh\` files executable"
todo="- findArguments is different here than other places"$'\n'""
usage="bashMakeExecutable [ --find findArguments ] [ path ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashMakeExecutable'$'\e''[0m '$'\e''[[(blue)]m[ --find findArguments ]'$'\e''[0m '$'\e''[[(blue)]m[ path ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--find findArguments  '$'\e''[[(value)]mString. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpath ...              '$'\e''[[(value)]mDirectory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.'$'\e''[[(reset)]m'$'\n'''$'\n''Makes all '$'\e''[[(code)]m'$'\e''[[(cyan)]m.sh'$'\e''[[(reset)]m files executable'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Works from the current directory'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashMakeExecutable [ --find findArguments ] [ path ... ]'$'\n'''$'\n''    --find findArguments  String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.'$'\n''    path ...              Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.'$'\n'''$'\n''Makes all .sh files executable'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Works from the current directory'$'\n'''
# elapsed 0.539
