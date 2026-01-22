#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"--escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
description="Copy file from source to destination"$'\n'""$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Failed"$'\n'""
file="bin/build/tools/interactive.sh"
fn="fileCopy"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1769063211"
summary="Copy file from source to destination"
usage="fileCopy [ --map ] [ --escalate ] source destination"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileCopy[0m [94m[ --map ][0m [94m[ --escalate ][0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mdestination[0m[0m

    [94m--map        [1;97mFlag. Optional. Map environment values into file before copying.[0m
    [94m--escalate   [1;97mFlag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.[0m
    [31msource       [1;97mFile. Required. Source path[0m
    [31mdestination  [1;97mFile. Required. Destination path[0m

Copy file from source to destination

Supports mapping the file using the current environment, or escalated privileges.
Return Code: 0 - Success
Return Code: 1 - Failed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileCopy [ --map ] [ --escalate ] source destination

    --map        Flag. Optional. Map environment values into file before copying.
    --escalate   Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.
    source       File. Required. Source path
    destination  File. Required. Destination path

Copy file from source to destination

Supports mapping the file using the current environment, or escalated privileges.
Return Code: 0 - Success
Return Code: 1 - Failed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
