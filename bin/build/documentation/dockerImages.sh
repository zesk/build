#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="--filter reference - String. Optional. Filter list by reference provided."$'\n'""
base="docker.sh"
description="List docker images which are currently pulled"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerImages"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1768759328"
summary="List docker images which are currently pulled"
usage="dockerImages [ --filter reference ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerImages[0m [94m[ --filter reference ][0m

    [94m--filter reference  [1;97mString. Optional. Filter list by reference provided.[0m

List docker images which are currently pulled

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerImages [ --filter reference ]

    --filter reference  String. Optional. Filter list by reference provided.

List docker images which are currently pulled

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
