#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="none"
base="debug.sh"
description="Returns whether the shell has the error exit flag set"$'\n'""$'\n'"Useful if you need to temporarily enable or disable it."$'\n'""$'\n'"October 2024 - Does appear to be inherited by subshells"$'\n'""$'\n'"    set -e"$'\n'"    printf \"\$(isErrorExit; printf %d \$?)\""$'\n'""$'\n'"Outputs \`1\` always"$'\n'""
file="bin/build/tools/debug.sh"
fn="isErrorExit"
foundNames=([0]="requires")
requires="-"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debug.sh"
sourceModified="1768687749"
summary="Returns whether the shell has the error exit flag set"
usage="isErrorExit"
