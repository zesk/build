#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hooks.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--application application - Directory. Optional. Application home directory."$'\n'""
base="hooks.sh"
description="Application deployed version"$'\n'""
file="bin/build/tools/hooks.sh"
fn="hookVersionLive"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hooks.sh"
sourceModified="1768721470"
summary="Application deployed version"
usage="hookVersionLive [ --help ] [ --application application ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mhookVersionLive[0m [94m[ --help ][0m [94m[ --application application ][0m

    [94m--help                     [1;97mFlag. Optional. Display this help.[0m
    [94m--application application  [1;97mDirectory. Optional. Application home directory.[0m

Application deployed version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: hookVersionLive [ --help ] [ --application application ]

    --help                     Flag. Optional. Display this help.
    --application application  Directory. Optional. Application home directory.

Application deployed version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
