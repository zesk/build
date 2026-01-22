#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="suffix - String. Optional. Directory suffix - created if does not exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Get the cache directory for the documentation"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationBuildCache"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769065497"
summary="Get the cache directory for the documentation"
usage="documentationBuildCache [ suffix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationBuildCache[0m [94m[ suffix ][0m [94m[ --help ][0m

    [94msuffix  [1;97mString. Optional. Directory suffix - created if does not exist.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Get the cache directory for the documentation

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationBuildCache [ suffix ] [ --help ]

    suffix  String. Optional. Directory suffix - created if does not exist.
    --help  Flag. Optional. Display this help.

Get the cache directory for the documentation

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
