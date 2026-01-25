#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
description="Look user up, output user home directory"$'\n'""
exitCode="0"
file="bin/build/tools/user.sh"
foundNames=([0]="summary" [1]="stdout" [2]="file" [3]="argument")
rawComment="Summary: Quick user database query of the user home directory"$'\n'"Look user up, output user home directory"$'\n'"stdout: \`Directory\`. The user home directory."$'\n'"File: /etc/passwd - Used for the default user database."$'\n'"Argument: user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"Argument: database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceModified="1768246145"
stdout="\`Directory\`. The user home directory."$'\n'""
summary="Quick user database query of the user home directory"$'\n'""
usage="userRecordHome [ user ] [ database ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]muserRecordHome'$'\e''[0m '$'\e''[[blue]m[ user ]'$'\e''[0m '$'\e''[[blue]m[ database ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]muser      '$'\e''[[value]mString. Optional. User name to look up. Uses '$'\e''[[code]mwhoami'$'\e''[[reset]m if not supplied.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mdatabase  '$'\e''[[value]mFile. Optional. User name database file to examine. Uses '$'\e''[[code]m/etc/passwd'$'\e''[[reset]m if not supplied.'$'\e''[[reset]m'$'\n'''$'\n''Look user up, output user home directory'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n'''$'\e''[[code]mDirectory'$'\e''[[reset]m. The user home directory.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: userRecordHome [ user ] [ database ]'$'\n'''$'\n''    user      String. Optional. User name to look up. Uses whoami if not supplied.'$'\n''    database  File. Optional. User name database file to examine. Uses /etc/passwd if not supplied.'$'\n'''$'\n''Look user up, output user home directory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Directory. The user home directory.'$'\n'''
