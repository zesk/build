#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Optional. Directory to check if empty."$'\n'""
base="directory.sh"
description="Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryIsEmpty"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1769063211"
summary="Does a directory exist and is it empty?"
usage="directoryIsEmpty [ directory ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryIsEmpty[0m [94m[ directory ][0m

    [94mdirectory  [1;97mDirectory. Optional. Directory to check if empty.[0m

Does a directory exist and is it empty?
Return Code: 2 - Directory does not exist
Return Code: 1 - Directory is not empty
Return Code: 0 - Directory is empty

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryIsEmpty [ directory ]

    directory  Directory. Optional. Directory to check if empty.

Does a directory exist and is it empty?
Return Code: 2 - Directory does not exist
Return Code: 1 - Directory is not empty
Return Code: 0 - Directory is empty

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
