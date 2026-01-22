#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apt.sh"
argument="keyName - String. Required. One or more key names to remove."$'\n'"--skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="apt.sh"
description="Remove apt keys"$'\n'""$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key was removed AOK"$'\n'""$'\n'""
file="bin/build/tools/apt.sh"
fn="aptKeyRemove"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceModified="1769063211"
summary="Remove apt keys"
usage="aptKeyRemove keyName [ --skip ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255maptKeyRemove[0m [38;2;255;255;0m[35;48;2;0;0;0mkeyName[0m[0m [94m[ --skip ][0m [94m[ --help ][0m

    [31mkeyName  [1;97mString. Required. One or more key names to remove.[0m
    [94m--skip   [1;97mFlag. Optional. a Do not do [38;2;0;255;0;48;2;0;0;0mapt-get update[0m afterwards to update the database.[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Remove apt keys

Return Code: 1 - if environment is awry
Return Code: 0 - Apt key was removed AOK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyRemove keyName [ --skip ] [ --help ]

    keyName  String. Required. One or more key names to remove.
    --skip   Flag. Optional. a Do not do apt-get update afterwards to update the database.
    --help   Flag. Optional. Display this help.

Remove apt keys

Return Code: 1 - if environment is awry
Return Code: 0 - Apt key was removed AOK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
