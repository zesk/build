#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="developer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Undo a set of developer functions or aliases\n\n'
descriptionLineCount="2"
file="bin/build/tools/developer.sh"
fn="developerUndo"
fnMarker="developerundo"
foundNames=([0]="stdin")
line="68"
rawComment=$'Undo a set of developer functions or aliases\nstdin: List of functions and aliases to remove from the current environment\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/developer.sh"
sourceHash="cbbc092a821837875415856193f556aae0aabd6f"
sourceLine="68"
stdin=$'List of functions and aliases to remove from the current environment\n'
summary="Undo a set of developer functions or aliases"
summaryComputed="true"
usage="developerUndo"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeveloperUndo'$'\e''[0m'$'\n'''$'\n''Undo a set of developer functions or aliases'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''List of functions and aliases to remove from the current environment'
# shellcheck disable=SC2016
helpPlain='Usage: developerUndo'$'\n'''$'\n''Undo a set of developer functions or aliases'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''List of functions and aliases to remove from the current environment'
documentationPath="documentation/source/tools/developer.md"
