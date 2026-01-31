#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="group.sh"
description="Convert a group name to a group ID"$'\n'"Argument: groupName - String. Required. Group name to convert to a group ID"$'\n'"stdout: \`Integer\`. One line for each group name passed as an argument."$'\n'"Return Code: 0 - All groups were found in the database and IDs were output successfully"$'\n'"Return Code: 1 - Any group is not found in the database."$'\n'"Return Code: 2 - Argument errors (blank argument)"$'\n'"Requires: throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern"$'\n'""
file="bin/build/tools/group.sh"
foundNames=()
rawComment="Convert a group name to a group ID"$'\n'"Argument: groupName - String. Required. Group name to convert to a group ID"$'\n'"stdout: \`Integer\`. One line for each group name passed as an argument."$'\n'"Return Code: 0 - All groups were found in the database and IDs were output successfully"$'\n'"Return Code: 1 - Any group is not found in the database."$'\n'"Return Code: 2 - Argument errors (blank argument)"$'\n'"Requires: throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/group.sh"
sourceHash="6dc790bd970c3b4bca3fcf206791b6596315d404"
summary="Convert a group name to a group ID"
usage="groupID"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgroupID'$'\e''[0m'$'\n'''$'\n''Convert a group name to a group ID'$'\n''Argument: groupName - String. Required. Group name to convert to a group ID'$'\n''stdout: '$'\e''[[(code)]mInteger'$'\e''[[(reset)]m. One line for each group name passed as an argument.'$'\n''Return Code: 0 - All groups were found in the database and IDs were output successfully'$'\n''Return Code: 1 - Any group is not found in the database.'$'\n''Return Code: 2 - Argument errors (blank argument)'$'\n''Requires: throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: groupID'$'\n'''$'\n''Convert a group name to a group ID'$'\n''Argument: groupName - String. Required. Group name to convert to a group ID'$'\n''stdout: Integer. One line for each group name passed as an argument.'$'\n''Return Code: 0 - All groups were found in the database and IDs were output successfully'$'\n''Return Code: 1 - Any group is not found in the database.'$'\n''Return Code: 2 - Argument errors (blank argument)'$'\n''Requires: throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
