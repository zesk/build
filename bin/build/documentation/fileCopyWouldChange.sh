#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
description="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'"Return Code: 0 - Something would change"$'\n'"Return Code: 1 - Nothing would change"$'\n'""
file="bin/build/tools/interactive.sh"
fn="fileCopyWouldChange"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Check whether copying a file would change it"
usage="fileCopyWouldChange [ --map ] source destination"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileCopyWouldChange[0m [94m[ --map ][0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mdestination[0m[0m

    [94m--map        [1;97mFlag. Optional. Map environment values into file before copying.[0m
    [31msource       [1;97mFile. Required. Source path[0m
    [31mdestination  [1;97mFile. Required. Destination path[0m

Check whether copying a file would change it
This function does not modify the source or destination.
Return Code: 0 - Something would change
Return Code: 1 - Nothing would change

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileCopyWouldChange [ --map ] source destination

    --map        Flag. Optional. Map environment values into file before copying.
    source       File. Required. Source path
    destination  File. Required. Destination path

Check whether copying a file would change it
This function does not modify the source or destination.
Return Code: 0 - Something would change
Return Code: 1 - Nothing would change

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
