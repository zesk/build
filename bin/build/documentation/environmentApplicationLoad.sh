#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'""
environment="BUILD_TIMESTAMP"$'\n'"APPLICATION_BUILD_DATE"$'\n'"APPLICATION_VERSION"$'\n'"APPLICATION_ID"$'\n'"APPLICATION_TAG"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentApplicationLoad"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Loads application environment variables, set them to their default values"
usage="environmentApplicationLoad [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentApplicationLoad[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TIMESTAMP
- APPLICATION_BUILD_DATE
- APPLICATION_VERSION
- APPLICATION_ID
- APPLICATION_TAG
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentApplicationLoad [ --help ]

    --help  Flag. Optional. Display this help.

Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TIMESTAMP
- APPLICATION_BUILD_DATE
- APPLICATION_VERSION
- APPLICATION_ID
- APPLICATION_TAG
- 
'
