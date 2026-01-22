#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="pipeline.sh"
description="Get the current IP address of a host"$'\n'""
environment="IP_URL"$'\n'"IP_URL_FILTER"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="ipLookup"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pipeline.sh"
sourceModified="1769063211"
summary="Get the current IP address of a host"
usage="ipLookup [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mipLookup[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Get the current IP address of a host

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- IP_URL
- IP_URL_FILTER
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: ipLookup [ --help ]

    --help  Flag. Optional. Display this help.

Get the current IP address of a host

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- IP_URL
- IP_URL_FILTER
- 
'
