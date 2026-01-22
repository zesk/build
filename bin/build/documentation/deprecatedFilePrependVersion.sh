#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="target - File. Required. File to update."$'\n'"version - String. Required. Version to place at the top of the file."$'\n'""
base="deprecated-tools.sh"
description="Take a deprecated.txt file and add a comment with the current version number to the top"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFilePrependVersion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1768721469"
summary="Take a deprecated.txt file and add a comment with the"
usage="deprecatedFilePrependVersion target version"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeprecatedFilePrependVersion[0m [38;2;255;255;0m[35;48;2;0;0;0mtarget[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mversion[0m[0m

    [31mtarget   [1;97mFile. Required. File to update.[0m
    [31mversion  [1;97mString. Required. Version to place at the top of the file.[0m

Take a deprecated.txt file and add a comment with the current version number to the top

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedFilePrependVersion target version

    target   File. Required. File to update.
    version  String. Required. Version to place at the top of the file.

Take a deprecated.txt file and add a comment with the current version number to the top

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
