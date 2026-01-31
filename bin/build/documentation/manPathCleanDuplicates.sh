#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="manpath.sh"
description="Cleans the MANPATH and removes non-directory entries and duplicates"$'\n'"Maintains ordering."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"No-Arguments: default"$'\n'""
file="bin/build/tools/manpath.sh"
foundNames=()
rawComment="Cleans the MANPATH and removes non-directory entries and duplicates"$'\n'"Maintains ordering."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"No-Arguments: default"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="8a6b17740b41a6485576efda52769baec3f7ddd4"
summary="Cleans the MANPATH and removes non-directory entries and duplicates"
usage="manPathCleanDuplicates"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmanPathCleanDuplicates'$'\e''[0m'$'\n'''$'\n''Cleans the MANPATH and removes non-directory entries and duplicates'$'\n''Maintains ordering.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''No-Arguments: default'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: manPathCleanDuplicates'$'\n'''$'\n''Cleans the MANPATH and removes non-directory entries and duplicates'$'\n''Maintains ordering.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''No-Arguments: default'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.462
