#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="path.sh"
description="Remove a path from the PATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Requires. String. The path to be removed from the \`PATH\` environment."$'\n'""
file="bin/build/tools/path.sh"
foundNames=()
rawComment="Remove a path from the PATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Requires. String. The path to be removed from the \`PATH\` environment."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="8a081a9a1154d0671a3f695f37287f54f605e380"
summary="Remove a path from the PATH environment variable"
usage="pathRemove"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathRemove'$'\e''[0m'$'\n'''$'\n''Remove a path from the PATH environment variable'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: path - Requires. String. The path to be removed from the '$'\e''[[(code)]mPATH'$'\e''[[(reset)]m environment.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathRemove'$'\n'''$'\n''Remove a path from the PATH environment variable'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: path - Requires. String. The path to be removed from the PATH environment.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.744
