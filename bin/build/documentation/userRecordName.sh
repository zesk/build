#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
description="Look user up, output user name"$'\n'""
file="bin/build/tools/user.sh"
foundNames=([0]="summary" [1]="stdout" [2]="file" [3]="argument")
rawComment="Summary: Quick user database query of the user name"$'\n'"Look user up, output user name"$'\n'"stdout: the user name"$'\n'"File: /etc/passwd"$'\n'"Argument: user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"Argument: database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceHash="3e129c267173e6702926193e8e7d4f847f1f0619"
stdout="the user name"$'\n'""
summary="Quick user database query of the user name"$'\n'""
usage="userRecordName [ user ] [ database ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]muserRecordName'$'\e''[0m '$'\e''[[(blue)]m[ user ]'$'\e''[0m '$'\e''[[(blue)]m[ database ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]muser      '$'\e''[[(value)]mString. Optional. User name to look up. Uses '$'\e''[[(code)]mwhoami'$'\e''[[(reset)]m if not supplied.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdatabase  '$'\e''[[(value)]mFile. Optional. User name database file to examine. Uses '$'\e''[[(code)]m/etc/passwd'$'\e''[[(reset)]m if not supplied.'$'\e''[[(reset)]m'$'\n'''$'\n''Look user up, output user name'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''the user name'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: userRecordName [ user ] [ database ]'$'\n'''$'\n''    user      String. Optional. User name to look up. Uses whoami if not supplied.'$'\n''    database  File. Optional. User name database file to examine. Uses /etc/passwd if not supplied.'$'\n'''$'\n''Look user up, output user name'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''the user name'$'\n'''
# elapsed 0.577
