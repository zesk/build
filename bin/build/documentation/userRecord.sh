#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="index - PositiveInteger. Required. Index (1-based) of field to select."$'\n'"user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
description="Look user up, output a single user database record."$'\n'""
file="bin/build/tools/user.sh"
fn="userRecord"
foundNames=""
requires="grep cut returnMessage printf /etc/passwd whoami"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceModified="1768246145"
stdout="String. Associated record with \`index\` and \`user\`."$'\n'""
summary="Quick user database look up"$'\n'""
usage="userRecord index [ user ] [ database ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255muserRecord[0m [38;2;255;255;0m[35;48;2;0;0;0mindex[0m[0m [94m[ user ][0m [94m[ database ][0m

    [31mindex     [1;97mPositiveInteger. Required. Index (1-based) of field to select.[0m
    [94muser      [1;97mString. Optional. User name to look up. Uses [38;2;0;255;0;48;2;0;0;0mwhoami[0m if not supplied.[0m
    [94mdatabase  [1;97mFile. Optional. User name database file to examine. Uses [38;2;0;255;0;48;2;0;0;0m/etc/passwd[0m if not supplied.[0m

Look user up, output a single user database record.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
String. Associated record with [38;2;0;255;0;48;2;0;0;0mindex[0m and [38;2;0;255;0;48;2;0;0;0muser[0m.
'
# shellcheck disable=SC2016
helpPlain='Usage: userRecord index [ user ] [ database ]

    index     PositiveInteger. Required. Index (1-based) of field to select.
    user      String. Optional. User name to look up. Uses whoami if not supplied.
    database  File. Optional. User name database file to examine. Uses /etc/passwd if not supplied.

Look user up, output a single user database record.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. Associated record with index and user.
'
