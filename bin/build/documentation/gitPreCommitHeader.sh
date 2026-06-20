#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'extension - String. Optional. Extension to display\n--help - Flag. Optional. Display this help.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a display for pre-commit files changed.\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitPreCommitHeader"
fnMarker="gitprecommitheader"
foundNames=([0]="argument")
line="904"
original="gitPreCommitHeader"
rawComment=$'Output a display for pre-commit files changed.\nArgument: extension - String. Optional. Extension to display\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="5e91a5d4b3beafc28e8b01755133cb215bd453d8"
sourceLine="904"
summary="Output a display for pre-commit files changed."
summaryComputed="true"
usage="gitPreCommitHeader [ extension ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitHeader'$'\e''[0m '$'\e''[[(blue)]m[ extension ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mextension  '$'\e''[[(value)]mString. Optional. Extension to display'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a display for pre-commit files changed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitHeader [ extension ] [ --help ]'$'\n'''$'\n''    extension  String. Optional. Extension to display'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Output a display for pre-commit files changed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
