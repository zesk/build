#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="developer.sh"
description="Undo a set of developer functions or aliases"$'\n'""
file="bin/build/tools/developer.sh"
fn="developerUndo"
foundNames=([0]="stdin")
line="68"
lowerFn="developerundo"
rawComment="Undo a set of developer functions or aliases"$'\n'"stdin: List of functions and aliases to remove from the current environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceHash="8c2a975491f7507fb67c8c10e6a859adcc647b31"
sourceLine="68"
stdin="List of functions and aliases to remove from the current environment"$'\n'""
summary="Undo a set of developer functions or aliases"
summaryComputed="true"
usage="developerUndo"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeveloperUndo'$'\e''[0m'$'\n'''$'\n''Undo a set of developer functions or aliases'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''List of functions and aliases to remove from the current environment'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: developerUndo'$'\n'''$'\n''Undo a set of developer functions or aliases'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''List of functions and aliases to remove from the current environment'$'\n'''
documentationPath="documentation/source/tools/developer.md"
