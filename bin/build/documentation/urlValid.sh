#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url ... - String. URL. Required. A Uniform Resource Locator"$'\n'""
base="url.sh"
description="Checks if a URL is valid"$'\n'"Return Code: 0 - all URLs passed in are valid"$'\n'"Return Code: 1 - at least one URL passed in is not a valid URL"$'\n'""
file="bin/build/tools/url.sh"
fn="urlValid"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1768721470"
summary="Checks if a URL is valid"
usage="urlValid [ --help ] url ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlValid[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0murl ...[0m[0m

    [94m--help   [1;97mFlag. Optional. Display this help.[0m
    [31murl ...  [1;97mString. URL. Required. A Uniform Resource Locator[0m

Checks if a URL is valid
Return Code: 0 - all URLs passed in are valid
Return Code: 1 - at least one URL passed in is not a valid URL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: urlValid [ --help ] url ...

    --help   Flag. Optional. Display this help.
    url ...  String. URL. Required. A Uniform Resource Locator

Checks if a URL is valid
Return Code: 0 - all URLs passed in are valid
Return Code: 1 - at least one URL passed in is not a valid URL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
