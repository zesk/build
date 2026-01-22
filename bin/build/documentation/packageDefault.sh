#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="none"
base="package.sh"
description="Fetch the binary name for the default package in a group"$'\n'"Groups are:"$'\n'"- mysql"$'\n'"- mysqldump"$'\n'""
file="bin/build/tools/package.sh"
fn="packageDefault"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Fetch the binary name for the default package in a"
usage="packageDefault"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageDefault[0m

Fetch the binary name for the default package in a group
Groups are:
- mysql
- mysqldump

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageDefault

Fetch the binary name for the default package in a group
Groups are:
- mysql
- mysqldump

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
