#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"binary - String. Required. The binary to look for."$'\n'""
base="version.sh"
description="Check if something matches a version"$'\n'""
file="bin/build/tools/version.sh"
fn="isVersion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceModified="1768759818"
summary="Check if something matches a version"
usage="isVersion [ --help ] binary"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misVersion[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [31mbinary  [1;97mString. Required. The binary to look for.[0m

Check if something matches a version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isVersion [ --help ] binary

    --help  Flag. Optional. Display this help.
    binary  String. Required. The binary to look for.

Check if something matches a version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
