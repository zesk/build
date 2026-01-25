#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/group.sh"
argument="groupName - String. Required. Group name to convert to a group ID"$'\n'""
base="group.sh"
description="Convert a group name to a group ID"$'\n'""
exitCode="0"
file="bin/build/tools/group.sh"
foundNames=([0]="argument" [1]="stdout" [2]="return_code" [3]="requires")
rawComment="Convert a group name to a group ID"$'\n'"Argument: groupName - String. Required. Group name to convert to a group ID"$'\n'"stdout: \`Integer\`. One line for each group name passed as an argument."$'\n'"Return Code: 0 - All groups were found in the database and IDs were output successfully"$'\n'"Return Code: 1 - Any group is not found in the database."$'\n'"Return Code: 2 - Argument errors (blank argument)"$'\n'"Requires: throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern"$'\n'""$'\n'""
requires="throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern"$'\n'""
return_code="0 - All groups were found in the database and IDs were output successfully"$'\n'"1 - Any group is not found in the database."$'\n'"2 - Argument errors (blank argument)"$'\n'""
sourceModified="1769184734"
stdout="\`Integer\`. One line for each group name passed as an argument."$'\n'""
summary="Convert a group name to a group ID"
usage="groupID groupName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgroupID'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mgroupName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mgroupName  '$'\e''[[value]mString. Required. Group name to convert to a group ID'$'\e''[[reset]m'$'\n'''$'\n''Convert a group name to a group ID'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - All groups were found in the database and IDs were output successfully'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Any group is not found in the database.'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument errors (blank argument)'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n'''$'\e''[[code]mInteger'$'\e''[[reset]m. One line for each group name passed as an argument.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: groupID groupName'$'\n'''$'\n''    groupName  String. Required. Group name to convert to a group ID'$'\n'''$'\n''Convert a group name to a group ID'$'\n'''$'\n''Return codes:'$'\n''- 0 - All groups were found in the database and IDs were output successfully'$'\n''- 1 - Any group is not found in the database.'$'\n''- 2 - Argument errors (blank argument)'$'\n'''$'\n''Writes to stdout:'$'\n''Integer. One line for each group name passed as an argument.'$'\n'''
