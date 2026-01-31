#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="platform.sh"
description="Makes all \`*.sh\` files executable"$'\n'"TODO: - findArguments is different here than other places"$'\n'"Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'"Environment: Works from the current directory"$'\n'"See: bashMakeExecutable"$'\n'"See: chmod-sh.sh"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=()
rawComment="Makes all \`*.sh\` files executable"$'\n'"TODO: - findArguments is different here than other places"$'\n'"Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'"Environment: Works from the current directory"$'\n'"See: bashMakeExecutable"$'\n'"See: chmod-sh.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="a1e5b60c969c8edace1146de6c1a3e07b2d6a084"
summary="Makes all \`*.sh\` files executable"
usage="bashMakeExecutable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashMakeExecutable'$'\e''[0m'$'\n'''$'\n''Makes all '$'\e''[[(code)]m'$'\e''[[(cyan)]m.sh'$'\e''[[(reset)]m files executable'$'\e''[[(reset)]m'$'\n''TODO: - findArguments is different here than other places'$'\n''Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.'$'\n''Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.'$'\n''Environment: Works from the current directory'$'\n''See: bashMakeExecutable'$'\n''See: chmod-sh.sh'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashMakeExecutable'$'\n'''$'\n''Makes all .sh files executable'$'\n''TODO: - findArguments is different here than other places'$'\n''Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.'$'\n''Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.'$'\n''Environment: Works from the current directory'$'\n''See: bashMakeExecutable'$'\n''See: chmod-sh.sh'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.43
