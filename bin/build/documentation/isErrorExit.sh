#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Returns whether the shell has the error exit flag set\n\nUseful if you need to temporarily enable or disable it.\n\nOctober 2024 - Does appear to be inherited by subshells\n\n    set -e\n    printf "$(isErrorExit; printf %d $?)"\n\nOutputs `1` always\n\n'
descriptionLineCount="11"
file="bin/build/tools/debug.sh"
fn="isErrorExit"
fnMarker="iserrorexit"
foundNames=([0]="requires")
line="275"
rawComment=$'Returns whether the shell has the error exit flag set\nUseful if you need to temporarily enable or disable it.\nOctober 2024 - Does appear to be inherited by subshells\n    set -e\n    printf "$(isErrorExit; printf %d $?)"\nOutputs `1` always\nRequires: -\n\n'
requires=$'-\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="275"
summary="Returns whether the shell has the error exit flag set"
summaryComputed="true"
usage="isErrorExit"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misErrorExit'$'\e''[0m'$'\n'''$'\n''Returns whether the shell has the error exit flag set'$'\n'''$'\n''Useful if you need to temporarily enable or disable it.'$'\n'''$'\n''October 2024 - Does appear to be inherited by subshells'$'\n'''$'\n''    set -e'$'\n''    printf "$(isErrorExit; printf %d $?)"'$'\n'''$'\n''Outputs '$'\e''[[(code)]m1'$'\e''[[(reset)]m always'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: isErrorExit'$'\n'''$'\n''Returns whether the shell has the error exit flag set'$'\n'''$'\n''Useful if you need to temporarily enable or disable it.'$'\n'''$'\n''October 2024 - Does appear to be inherited by subshells'$'\n'''$'\n''    set -e'$'\n''    printf "$(isErrorExit; printf %d $?)"'$'\n'''$'\n''Outputs 1 always'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/debug.md"
