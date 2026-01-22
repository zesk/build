#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="source - Directory. Required. target"$'\n'"target - FileDirectory. Required."$'\n'""
base="directory.sh"
description="Copy directory over another sort-of-atomically"$'\n'""$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryClobber"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Copy directory over another sort-of-atomically"
usage="directoryClobber source target"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryClobber[0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtarget[0m[0m

    [31msource  [1;97mDirectory. Required. target[0m
    [31mtarget  [1;97mFileDirectory. Required.[0m

Copy directory over another sort-of-atomically

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryClobber source target

    source  Directory. Required. target
    target  FileDirectory. Required.

Copy directory over another sort-of-atomically

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
