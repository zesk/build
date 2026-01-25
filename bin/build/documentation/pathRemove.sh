#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/path.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"path - Requires. String. The path to be removed from the \`PATH\` environment."$'\n'""
base="path.sh"
description="Remove a path from the PATH environment variable"$'\n'""
exitCode="0"
file="bin/build/tools/path.sh"
rawComment="Remove a path from the PATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Requires. String. The path to be removed from the \`PATH\` environment."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceModified="1769063211"
summary="Remove a path from the PATH environment variable"
usage="pathRemove [ --help ] [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpathRemove'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mpath    '$'\e''[[value]mRequires. String. The path to be removed from the '$'\e''[[code]mPATH'$'\e''[[reset]m environment.'$'\e''[[reset]m'$'\n'''$'\n''Remove a path from the PATH environment variable'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathRemove [ --help ] [ path ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    path    Requires. String. The path to be removed from the PATH environment.'$'\n'''$'\n''Remove a path from the PATH environment variable'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
