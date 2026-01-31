#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="manpath.sh"
description="Remove a path from the MANPATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'""
file="bin/build/tools/manpath.sh"
foundNames=()
rawComment="Remove a path from the MANPATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="8a6b17740b41a6485576efda52769baec3f7ddd4"
summary="Remove a path from the MANPATH environment variable"
usage="manPathRemove"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmanPathRemove'$'\e''[0m'$'\n'''$'\n''Remove a path from the MANPATH environment variable'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: path - Directory. Required. The path to be removed from the '$'\e''[[(code)]mMANPATH'$'\e''[[(reset)]m environment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: manPathRemove'$'\n'''$'\n''Remove a path from the MANPATH environment variable'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: path - Directory. Required. The path to be removed from the MANPATH environment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.47
