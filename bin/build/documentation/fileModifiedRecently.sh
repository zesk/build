#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'directory - Directory. Required. Must exists - directory to list.\nfindArgs - Arguments. Optional. Optional additional arguments to modify the find query\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List the most recently modified file in a directory prefixed with the timestamp\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileModifiedRecently"
fnMarker="filemodifiedrecently"
foundNames=([0]="argument")
line="241"
rawComment=$'List the most recently modified file in a directory prefixed with the timestamp\nArgument: directory - Directory. Required. Must exists - directory to list.\nArgument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="c688f25ccc836a3de5e08fcee0b11da564d05e7a"
sourceLine="241"
summary="List the most recently modified file in a directory prefixed"
summaryComputed="true"
usage="fileModifiedRecently directory [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedRecently'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ findArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Must exists - directory to list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfindArgs   '$'\e''[[(value)]mArguments. Optional. Optional additional arguments to modify the find query'$'\e''[[(reset)]m'$'\n'''$'\n''List the most recently modified file in a directory prefixed with the timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileModifiedRecently directory [ findArgs ]'$'\n'''$'\n''    directory  Directory. Required. Must exists - directory to list.'$'\n''    findArgs   Arguments. Optional. Optional additional arguments to modify the find query'$'\n'''$'\n''List the most recently modified file in a directory prefixed with the timestamp'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
