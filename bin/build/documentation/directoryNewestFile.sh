#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="directory - Directory. Required. Directory to search for the newest file."$'\n'"--find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""
base="file.sh"
description="Find the newest modified file in a directory"$'\n'""
file="bin/build/tools/file.sh"
fn="directoryNewestFile"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Find the newest modified file in a directory"
usage="directoryNewestFile directory [ --find findArgs ... -- ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryNewestFile[0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m [94m[ --find findArgs ... -- ][0m

    [31mdirectory               [1;97mDirectory. Required. Directory to search for the newest file.[0m
    [94m--find findArgs ... --  [1;97mArguments. Optional. Arguments delimited by a double-dash (or end of argument list)[0m

Find the newest modified file in a directory

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryNewestFile directory [ --find findArgs ... -- ]

    directory               Directory. Required. Directory to search for the newest file.
    --find findArgs ... --  Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)

Find the newest modified file in a directory

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
