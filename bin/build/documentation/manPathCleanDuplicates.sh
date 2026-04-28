#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-28
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="manpath.sh"
description="Cleans the MANPATH and removes non-directory entries and duplicates"$'\n'"Maintains ordering."$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathCleanDuplicates"
foundNames=([0]="argument" [1]="no_arguments")
line="59"
lowerFn="manpathcleanduplicates"
no_arguments="default"$'\n'""
rawComment="Cleans the MANPATH and removes non-directory entries and duplicates"$'\n'"Maintains ordering."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"No-Arguments: default"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="3610cefbf165c42a60f9d8dc4e7f3fbae16965f5"
sourceLine="59"
summary="Cleans the MANPATH and removes non-directory entries and duplicates"
summaryComputed="true"
usage="manPathCleanDuplicates [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmanPathCleanDuplicates'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Cleans the MANPATH and removes non-directory entries and duplicates'$'\n''Maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: manPathCleanDuplicates [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Cleans the MANPATH and removes non-directory entries and duplicates'$'\n''Maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/manpath.md"
