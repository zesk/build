#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="none"
base="debug.sh"
description="Returns whether the shell has the error exit flag set"$'\n'""$'\n'"Useful if you need to temporarily enable or disable it."$'\n'""$'\n'"October 2024 - Does appear to be inherited by subshells"$'\n'""$'\n'"    set -e"$'\n'"    printf \"\$(isErrorExit; printf %d \$?)\""$'\n'""$'\n'"Outputs \`1\` always"$'\n'""
file="bin/build/tools/debug.sh"
fn="isErrorExit"
requires="-"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769059754"
summary="Returns whether the shell has the error exit flag set"
usage="isErrorExit"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misErrorExit[0m

Returns whether the shell has the error exit flag set

Useful if you need to temporarily enable or disable it.

October 2024 - Does appear to be inherited by subshells

    set -e
    printf "$(isErrorExit; printf %d $?)"

Outputs [38;2;0;255;0;48;2;0;0;0m1[0m always

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isErrorExit

Returns whether the shell has the error exit flag set

Useful if you need to temporarily enable or disable it.

October 2024 - Does appear to be inherited by subshells

    set -e
    printf "$(isErrorExit; printf %d $?)"

Outputs 1 always

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
