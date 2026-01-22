#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="none"
base="developer.sh"
description="Undo a set of developer functions or aliases"$'\n'""
file="bin/build/tools/developer.sh"
fn="developerUndo"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceModified="1769063211"
stdin="List of functions and aliases to remove from the current environment"$'\n'""
summary="Undo a set of developer functions or aliases"
usage="developerUndo"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeveloperUndo[0m

Undo a set of developer functions or aliases

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
List of functions and aliases to remove from the current environment
'
# shellcheck disable=SC2016
helpPlain='Usage: developerUndo

Undo a set of developer functions or aliases

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
List of functions and aliases to remove from the current environment
'
