#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Returns whether the shell has the error exit flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'"October 2024 - Does appear to be inherited by subshells"$'\n'"    set -e"$'\n'"    printf \"\$(isErrorExit; printf %d \$?)\""$'\n'"Outputs \`1\` always"$'\n'""
file="bin/build/tools/debug.sh"
fn="isErrorExit"
foundNames=([0]="requires")
line="275"
lowerFn="iserrorexit"
rawComment="Returns whether the shell has the error exit flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'"October 2024 - Does appear to be inherited by subshells"$'\n'"    set -e"$'\n'"    printf \"\$(isErrorExit; printf %d \$?)\""$'\n'"Outputs \`1\` always"$'\n'"Requires: -"$'\n'""$'\n'""
requires="-"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="275"
summary="Returns whether the shell has the error exit flag set"
summaryComputed="true"
usage="isErrorExit"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misErrorExit'$'\e''[0m'$'\n'''$'\n''Returns whether the shell has the error exit flag set'$'\n''Useful if you need to temporarily enable or disable it.'$'\n''October 2024 - Does appear to be inherited by subshells'$'\n''    set -e'$'\n''    printf "$(isErrorExit; printf %d $?)"'$'\n''Outputs '$'\e''[[(code)]m1'$'\e''[[(reset)]m always'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isErrorExit'$'\n'''$'\n''Returns whether the shell has the error exit flag set'$'\n''Useful if you need to temporarily enable or disable it.'$'\n''October 2024 - Does appear to be inherited by subshells'$'\n''    set -e'$'\n''    printf "$(isErrorExit; printf %d $?)"'$'\n''Outputs 1 always'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/debug.md"
