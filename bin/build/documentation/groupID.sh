#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/group.sh"
argument="groupName - String. Required. Group name to convert to a group ID"$'\n'""
base="group.sh"
description="Convert a group name to a group ID"$'\n'"Return Code: 0 - All groups were found in the database and IDs were output successfully"$'\n'"Return Code: 1 - Any group is not found in the database."$'\n'"Return Code: 2 - Argument errors (blank argument)"$'\n'""
file="bin/build/tools/group.sh"
fn="groupID"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
requires="throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/group.sh"
sourceModified="1768246145"
stdout="\`Integer\`. One line for each group name passed as an argument."$'\n'""
summary="Convert a group name to a group ID"
usage="groupID groupName"
