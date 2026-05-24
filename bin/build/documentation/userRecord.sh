#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'index - PositiveInteger. Required. Index (1-based) of field to select.\nuser - String. Optional. User name to look up. Uses `whoami` if not supplied.\ndatabase - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.\n'
base="user.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Look user up, output a single user database record.\n\n'
descriptionLineCount="2"
file="bin/build/tools/user.sh"
fn="userRecord"
fnMarker="userrecord"
foundNames=([0]="argument" [1]="summary" [2]="stdout" [3]="file" [4]="requires")
line="38"
rawComment=$'Argument: index - PositiveInteger. Required. Index (1-based) of field to select.\nArgument: user - String. Optional. User name to look up. Uses `whoami` if not supplied.\nArgument: database - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.\nSummary: Quick user database look up\nLook user up, output a single user database record.\nstdout: String. Associated record with `index` and `user`.\nFile: /etc/passwd\nRequires: grep cut returnMessage printf /etc/passwd whoami\n\n'
requires=$'grep cut returnMessage printf /etc/passwd whoami\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/user.sh"
sourceHash="748c273a0fe671ed2423893475bacc1706b94267"
sourceLine="38"
stdout=$'String. Associated record with `index` and `user`.\n'
summary="Quick user database look up"
summaryComputed=""
usage="userRecord index [ user ] [ database ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]muserRecord'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mindex'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ user ]'$'\e''[0m '$'\e''[[(blue)]m[ database ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mindex     '$'\e''[[(value)]mPositiveInteger. Required. Index (1-based) of field to select.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]muser      '$'\e''[[(value)]mString. Optional. User name to look up. Uses '$'\e''[[(code)]mwhoami'$'\e''[[(reset)]m if not supplied.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdatabase  '$'\e''[[(value)]mFile. Optional. User name database file to examine. Uses '$'\e''[[(code)]m/etc/passwd'$'\e''[[(reset)]m if not supplied.'$'\e''[[(reset)]m'$'\n'''$'\n''Look user up, output a single user database record.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String. Associated record with '$'\e''[[(code)]mindex'$'\e''[[(reset)]m and '$'\e''[[(code)]muser'$'\e''[[(reset)]m.'
# shellcheck disable=SC2016
helpPlain='Usage: userRecord index [ user ] [ database ]'$'\n'''$'\n''    index     PositiveInteger. Required. Index (1-based) of field to select.'$'\n''    user      String. Optional. User name to look up. Uses whoami if not supplied.'$'\n''    database  File. Optional. User name database file to examine. Uses /etc/passwd if not supplied.'$'\n'''$'\n''Look user up, output a single user database record.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. Associated record with index and user.'
documentationPath="documentation/source/tools/user.md"
