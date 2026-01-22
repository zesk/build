#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to get"$'\n'""
base="json.sh"
description="Get a value in a JSON file"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonFileGet"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceModified="1768721469"
summary="Get a value in a JSON file"
usage="jsonFileGet jsonFile path"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mjsonFileGet[0m [38;2;255;255;0m[35;48;2;0;0;0mjsonFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mpath[0m[0m

    [31mjsonFile  [1;97mFile. Required. File to get value from.[0m
    [31mpath      [1;97mString. Required. dot-separated path to get[0m

Get a value in a JSON file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileGet jsonFile path

    jsonFile  File. Required. File to get value from.
    path      String. Required. dot-separated path to get

Get a value in a JSON file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
