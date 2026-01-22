#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/web.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. URL to check."$'\n'"file - File. Required. File to compare."$'\n'""
base="web.sh"
description="Compare a remote file size with a local file size"$'\n'""
file="bin/build/tools/web.sh"
fn="urlMatchesLocalFileSize"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceModified="1768721470"
summary="Compare a remote file size with a local file size"
usage="urlMatchesLocalFileSize [ --help ] url file"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlMatchesLocalFileSize[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0murl[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile[0m[0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [31murl     [1;97mURL. Required. URL to check.[0m
    [31mfile    [1;97mFile. Required. File to compare.[0m

Compare a remote file size with a local file size

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: urlMatchesLocalFileSize [ --help ] url file

    --help  Flag. Optional. Display this help.
    url     URL. Required. URL to check.
    file    File. Required. File to compare.

Compare a remote file size with a local file size

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
