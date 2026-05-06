#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="manpath.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Cleans the MANPATH and removes non-directory entries and duplicates"$'\n'""$'\n'"Maintains ordering."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/manpath.sh"
fn="manPathCleanDuplicates"
fnMarker="manpathcleanduplicates"
foundNames=([0]="argument" [1]="no_arguments")
line="59"
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
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmanPathCleanDuplicates'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Cleans the MANPATH and removes non-directory entries and duplicates'$'\n'''$'\n''Maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: manPathCleanDuplicates [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Cleans the MANPATH and removes non-directory entries and duplicates'$'\n'''$'\n''Maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/manpath.md"
