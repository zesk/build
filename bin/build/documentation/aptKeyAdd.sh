#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apt.sh"
argument="--title keyTitle - String. Optional. Title of the key."$'\n'"--name keyName - String. Required. Name of the key used to generate file names."$'\n'"--url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="apt.sh"
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'""$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key is installed AOK"$'\n'""$'\n'""
file="bin/build/tools/apt.sh"
fn="aptKeyAdd"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceModified="1769063211"
summary="Add keys to enable apt to download terraform directly from"
usage="aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255maptKeyAdd[0m [94m[ --title keyTitle ][0m [38;2;255;255;0m[35;48;2;0;0;0m--name keyName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--url remoteUrl[0m[0m [94m[ --help ][0m

    [94m--title keyTitle  [1;97mString. Optional. Title of the key.[0m
    [31m--name keyName    [1;97mString. Required. Name of the key used to generate file names.[0m
    [31m--url remoteUrl   [1;97mURL. Required. Remote URL of gpg key.[0m
    [94m--help            [1;97mFlag. Optional. Display this help.[0m

Add keys to enable apt to download terraform directly from hashicorp.com

Return Code: 1 - if environment is awry
Return Code: 0 - Apt key is installed AOK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]

    --title keyTitle  String. Optional. Title of the key.
    --name keyName    String. Required. Name of the key used to generate file names.
    --url remoteUrl   URL. Required. Remote URL of gpg key.
    --help            Flag. Optional. Display this help.

Add keys to enable apt to download terraform directly from hashicorp.com

Return Code: 1 - if environment is awry
Return Code: 0 - Apt key is installed AOK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
