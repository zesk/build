#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument=$'-a - Flag. Optional. Append target (atomically as well).\ntarget - File. Required. File to target\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Write to a file in a single operation to avoid invalid files\nEXPERIMENTAL not a lot of testing of this don\'t use quite yet.\n\n'
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileTeeAtomic"
fnMarker="fileteeatomic"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="summary")
line="979"
rawComment=$'Write to a file in a single operation to avoid invalid files\nArgument: -a - Flag. Optional. Append target (atomically as well).\nArgument: target - File. Required. File to target\nArgument: --help - Flag. Optional. Display this help.\nstdin: Piped to a temporary file until EOF and then moved to target\nstdout: A copy of stdin\nSummary: tee but atomic (EXPERIMENTAL)\nEXPERIMENTAL not a lot of testing of this don\'t use quite yet.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="1ddfd7452bcc3ae87f5e31f996487d77938a316d"
sourceLine="979"
stdin=$'Piped to a temporary file until EOF and then moved to target\n'
stdout=$'A copy of stdin\n'
summary="tee but atomic (EXPERIMENTAL)"
summaryComputed=""
usage="fileTeeAtomic [ -a ] target [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTeeAtomic'$'\e''[0m '$'\e''[[(blue)]m[ -a ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-a      '$'\e''[[(value)]mFlag. Optional. Append target (atomically as well).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtarget  '$'\e''[[(value)]mFile. Required. File to target'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n''EXPERIMENTAL not a lot of testing of this don'\''t use quite yet.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''A copy of stdin'
# shellcheck disable=SC2016
helpPlain='Usage: fileTeeAtomic [ -a ] target [ --help ]'$'\n'''$'\n''    -a      Flag. Optional. Append target (atomically as well).'$'\n''    target  File. Required. File to target'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Write to a file in a single operation to avoid invalid files'$'\n''EXPERIMENTAL not a lot of testing of this don'\''t use quite yet.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Piped to a temporary file until EOF and then moved to target'$'\n'''$'\n''Writes to stdout:'$'\n''A copy of stdin'
documentationPath="documentation/source/tools/file.md"
