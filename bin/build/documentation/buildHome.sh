#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Prints the build home directory (usually same as the application root)"$'\n'""
environment="BUILD_HOME"$'\n'""
file="bin/build/tools/build.sh"
fn="buildHome"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769063211"
summary="Prints the build home directory (usually same as the application"
usage="buildHome [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildHome[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Prints the build home directory (usually same as the application root)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOME
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildHome [ --help ]

    --help  Flag. Optional. Display this help.

Prints the build home directory (usually same as the application root)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOME
- 
'
