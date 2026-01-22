#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apk.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="apk.sh"
description="Is this an Alpine system and is apk installed?"$'\n'"Return Code: 0 - System is an alpine system and apk is installed"$'\n'"Return Code: 1 - System is not an alpine system or apk is not installed"$'\n'""
file="bin/build/tools/apk.sh"
fn="apkIsInstalled"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceModified="1769063211"
summary="Is this an Alpine system and is apk installed?"
usage="apkIsInstalled [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mapkIsInstalled[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Is this an Alpine system and is apk installed?
Return Code: 0 - System is an alpine system and apk is installed
Return Code: 1 - System is not an alpine system or apk is not installed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: apkIsInstalled [ --help ]

    --help  Flag. Optional. Display this help.

Is this an Alpine system and is apk installed?
Return Code: 0 - System is an alpine system and apk is installed
Return Code: 1 - System is not an alpine system or apk is not installed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
