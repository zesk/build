#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="none"
base="debug.sh"
depends="-"$'\n'""
description="Returns whether the shell has the debugging flag set"$'\n'""$'\n'"Useful if you need to temporarily enable or disable it."$'\n'""
file="bin/build/tools/debug.sh"
fn="isBashDebug"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769059754"
summary="Returns whether the shell has the debugging flag set"
usage="isBashDebug"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misBashDebug[0m

Returns whether the shell has the debugging flag set

Useful if you need to temporarily enable or disable it.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isBashDebug

Returns whether the shell has the debugging flag set

Useful if you need to temporarily enable or disable it.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
