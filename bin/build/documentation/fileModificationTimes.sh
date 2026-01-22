#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="directory - Directory. Required. Must exists - directory to list."$'\n'"findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
base="file.sh"
description="Lists files in a directory recursively along with their modification time in seconds."$'\n'""$'\n'"Output is unsorted."$'\n'""$'\n'""$'\n'""
example="fileModificationTimes \$myDir ! -path \"*/.*/*\""$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationTimes"
foundNames=""
output="1705347087 bin/build/tools.sh"$'\n'"1704312758 bin/build/deprecated.sh"$'\n'"1705442647 bin/build/build.json"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Lists files in a directory recursively along with their modification"
usage="fileModificationTimes directory [ findArgs ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileModificationTimes[0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m [94m[ findArgs ][0m

    [31mdirectory  [1;97mDirectory. Required. Must exists - directory to list.[0m
    [94mfindArgs   [1;97mArguments. Optional. Optional additional arguments to modify the find query[0m

Lists files in a directory recursively along with their modification time in seconds.

Output is unsorted.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
fileModificationTimes $myDir ! -path "[36m/.[0m/[36m"[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationTimes directory [ findArgs ]

    directory  Directory. Required. Must exists - directory to list.
    findArgs   Arguments. Optional. Optional additional arguments to modify the find query

Lists files in a directory recursively along with their modification time in seconds.

Output is unsorted.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
fileModificationTimes $myDir ! -path "/./"
'
