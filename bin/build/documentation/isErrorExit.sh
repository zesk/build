#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Returns whether the shell has the error exit flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'"October 2024 - Does appear to be inherited by subshells"$'\n'"    set -e"$'\n'"    printf \"\$(isErrorExit; printf %d \$?)\""$'\n'"Outputs \`1\` always"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="requires")
rawComment="Returns whether the shell has the error exit flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'"October 2024 - Does appear to be inherited by subshells"$'\n'"    set -e"$'\n'"    printf \"\$(isErrorExit; printf %d \$?)\""$'\n'"Outputs \`1\` always"$'\n'"Requires: -"$'\n'""$'\n'""
requires="-"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Returns whether the shell has the error exit flag set"
summaryComputed="true"
usage="isErrorExit"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misErrorExit'$'\e''[0m'$'\n'''$'\n''Returns whether the shell has the error exit flag set'$'\n''Useful if you need to temporarily enable or disable it.'$'\n''October 2024 - Does appear to be inherited by subshells'$'\n''    set -e'$'\n''    printf "$(isErrorExit; printf %d $?)"'$'\n''Outputs '$'\e''[[(code)]m1'$'\e''[[(reset)]m always'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]misErrorExit'$'\n'''$'\n''Returns whether the shell has the error exit flag set'$'\n''Useful if you need to temporarily enable or disable it.'$'\n''October 2024 - Does appear to be inherited by subshells'$'\n''    set -e'$'\n''    printf "$(isErrorExit; printf %d $?)"'$'\n''Outputs [[(code)]m1 always'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 3.283
