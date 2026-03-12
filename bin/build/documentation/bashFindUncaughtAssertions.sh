#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--exclude path - String. Optional. Exclude paths which contain this string"$'\n'"--exec binary - Executable. Optional. For each failed file run this command."$'\n'"directory - Directory. Optional. Where to search for files to check."$'\n'"--list - Flag. Optional. List files which fail. (Default is simply to exit silently.)"$'\n'""
base="lint.sh"
description="Search bash files for assertions which do not terminate a function and are likely an error"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashFindUncaughtAssertions"
foundNames=([0]="argument")
rawComment="Search bash files for assertions which do not terminate a function and are likely an error"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --exclude path - String. Optional. Exclude paths which contain this string"$'\n'"Argument: --exec binary - Executable. Optional. For each failed file run this command."$'\n'"Argument: directory - Directory. Optional. Where to search for files to check."$'\n'"Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="dcca834eb93c0078aad6d23ff607ce464551064b"
summary="Search bash files for assertions which do not terminate a"
summaryComputed="true"
usage="bashFindUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
