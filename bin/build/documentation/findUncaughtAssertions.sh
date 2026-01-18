#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--exclude path - String. Optional. Exclude paths which contain this string"$'\n'"--exec binary - Executable. Optional. For each failed file run this command."$'\n'"directory - Directory. Optional. Where to search for files to check."$'\n'"--list - Flag. Optional. List files which fail. (Default is simply to exit silently.)"$'\n'""
base="lint.sh"
description="Search bash files for assertions which do not terminate a function and are likely an error"$'\n'""
file="bin/build/tools/lint.sh"
fn="findUncaughtAssertions"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Search bash files for assertions which do not terminate a"
usage="findUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]"
