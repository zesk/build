#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/group.sh"
argument="groupName - String. Required. Group name to convert to a group ID"$'\n'""
base="group.sh"
description="Convert a group name to a group ID"$'\n'"Return Code: 0 - All groups were found in the database and IDs were output successfully"$'\n'"Return Code: 1 - Any group is not found in the database."$'\n'"Return Code: 2 - Argument errors (blank argument)"$'\n'""
file="bin/build/tools/group.sh"
fn="groupID"
foundNames=""
requires="throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/group.sh"
sourceModified="1768246145"
stdout="\`Integer\`. One line for each group name passed as an argument."$'\n'""
summary="Convert a group name to a group ID"
usage="groupID groupName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgroupID[0m [38;2;255;255;0m[35;48;2;0;0;0mgroupName[0m[0m

    [31mgroupName  [1;97mString. Required. Group name to convert to a group ID[0m

Convert a group name to a group ID
Return Code: 0 - All groups were found in the database and IDs were output successfully
Return Code: 1 - Any group is not found in the database.
Return Code: 2 - Argument errors (blank argument)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mInteger[0m. One line for each group name passed as an argument.
'
# shellcheck disable=SC2016
helpPlain='Usage: groupID groupName

    groupName  String. Required. Group name to convert to a group ID

Convert a group name to a group ID
Return Code: 0 - All groups were found in the database and IDs were output successfully
Return Code: 1 - Any group is not found in the database.
Return Code: 2 - Argument errors (blank argument)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Integer. One line for each group name passed as an argument.
'
