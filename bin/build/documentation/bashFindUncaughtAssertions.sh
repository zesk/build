#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="lint.sh"
description="Search bash files for assertions which do not terminate a function and are likely an error"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --exclude path - String. Optional. Exclude paths which contain this string"$'\n'"Argument: --exec binary - Executable. Optional. For each failed file run this command."$'\n'"Argument: directory - Directory. Optional. Where to search for files to check."$'\n'"Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)"$'\n'""
file="bin/build/tools/lint.sh"
foundNames=()
rawComment="Search bash files for assertions which do not terminate a function and are likely an error"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --exclude path - String. Optional. Exclude paths which contain this string"$'\n'"Argument: --exec binary - Executable. Optional. For each failed file run this command."$'\n'"Argument: directory - Directory. Optional. Where to search for files to check."$'\n'"Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="1117fb23c3a75ca6a646bab1404a8f455c97fb49"
summary="Search bash files for assertions which do not terminate a"
usage="bashFindUncaughtAssertions"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFindUncaughtAssertions'$'\e''[0m'$'\n'''$'\n''Search bash files for assertions which do not terminate a function and are likely an error'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --exclude path - String. Optional. Exclude paths which contain this string'$'\n''Argument: --exec binary - Executable. Optional. For each failed file run this command.'$'\n''Argument: directory - Directory. Optional. Where to search for files to check.'$'\n''Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashFindUncaughtAssertions'$'\n'''$'\n''Search bash files for assertions which do not terminate a function and are likely an error'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --exclude path - String. Optional. Exclude paths which contain this string'$'\n''Argument: --exec binary - Executable. Optional. For each failed file run this command.'$'\n''Argument: directory - Directory. Optional. Where to search for files to check.'$'\n''Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
