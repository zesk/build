#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="none"
base="developer.sh"
description="Undo a set of developer functions or aliases"$'\n'""
file="bin/build/tools/developer.sh"
foundNames=([0]="stdin")
rawComment="Undo a set of developer functions or aliases"$'\n'"stdin: List of functions and aliases to remove from the current environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceModified="1769184734"
stdin="List of functions and aliases to remove from the current environment"$'\n'""
summary="Undo a set of developer functions or aliases"
usage="developerUndo"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeveloperUndo'$'\e''[0m'$'\n'''$'\n''Undo a set of developer functions or aliases'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''List of functions and aliases to remove from the current environment'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: developerUndo'$'\n'''$'\n''Undo a set of developer functions or aliases'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''List of functions and aliases to remove from the current environment'$'\n'''
# elapsed 0.457
