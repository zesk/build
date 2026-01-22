#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
description="Look user up, output user name"$'\n'""
file="bin/build/tools/user.sh"
fn="userRecordName"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceModified="1768246145"
stdout="the user name"$'\n'""
summary="Quick user database query of the user name"$'\n'""
usage="userRecordName [ user ] [ database ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255muserRecordName[0m [94m[ user ][0m [94m[ database ][0m

    [94muser      [1;97mString. Optional. User name to look up. Uses [38;2;0;255;0;48;2;0;0;0mwhoami[0m if not supplied.[0m
    [94mdatabase  [1;97mFile. Optional. User name database file to examine. Uses [38;2;0;255;0;48;2;0;0;0m/etc/passwd[0m if not supplied.[0m

Look user up, output user name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
the user name
'
# shellcheck disable=SC2016
helpPlain='Usage: userRecordName [ user ] [ database ]

    user      String. Optional. User name to look up. Uses whoami if not supplied.
    database  File. Optional. User name database file to examine. Uses /etc/passwd if not supplied.

Look user up, output user name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
the user name
'
