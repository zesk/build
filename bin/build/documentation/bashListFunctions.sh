#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="List functions in a given shell file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: file - File. Optional. File(s) to list bash functions defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: __bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="List functions in a given shell file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: file - File. Optional. File(s) to list bash functions defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: __bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="List functions in a given shell file"
usage="bashListFunctions"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashListFunctions'$'\e''[0m'$'\n'''$'\n''List functions in a given shell file'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: file - File. Optional. File(s) to list bash functions defined within.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Requires: __bashListFunctions throwArgument decorate usageArgumentFile'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashListFunctions'$'\n'''$'\n''List functions in a given shell file'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: file - File. Optional. File(s) to list bash functions defined within.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Requires: __bashListFunctions throwArgument decorate usageArgumentFile'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.429
