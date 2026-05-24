#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--print - Flag. Optional. Show the command.\n--binary - Executable. Optional. The binary to use to do the dump. Defaults to `MARIADB_BINARY_DUMP`.\n--lock - Flag. Optional. Lock the database during dump\n--password password - String. Optional. Password to connect\n--user user - String. Optional. User to connect\n--host host - String. Optional. Host to connect\n--port port - Integer. Optional. Port to connect\n'
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Dump a MariaDB database to raw SQL\n\n'
descriptionLineCount="2"
file="bin/build/tools/mariadb.sh"
fn="mariadbDump"
fnMarker="mariadbdump"
foundNames=([0]="argument")
line="53"
rawComment=$'Dump a MariaDB database to raw SQL\nArgument: --help - Flag. Optional. Display this help.\nArgument: --print - Flag. Optional. Show the command.\nArgument: --binary - Executable. Optional. The binary to use to do the dump. Defaults to `MARIADB_BINARY_DUMP`.\nArgument: --lock - Flag. Optional. Lock the database during dump\nArgument: --password password - String. Optional. Password to connect\nArgument: --user user - String. Optional. User to connect\nArgument: --host host - String. Optional. Host to connect\nArgument: --port port - Integer. Optional. Port to connect\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="53"
summary="Dump a MariaDB database to raw SQL"
summaryComputed="true"
usage="mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbDump'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --print ]'$'\e''[0m '$'\e''[[(blue)]m[ --binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --lock ]'$'\e''[0m '$'\e''[[(blue)]m[ --password password ]'$'\e''[0m '$'\e''[[(blue)]m[ --user user ]'$'\e''[0m '$'\e''[[(blue)]m[ --host host ]'$'\e''[0m '$'\e''[[(blue)]m[ --port port ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--print              '$'\e''[[(value)]mFlag. Optional. Show the command.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--binary             '$'\e''[[(value)]mExecutable. Optional. The binary to use to do the dump. Defaults to '$'\e''[[(code)]mMARIADB_BINARY_DUMP'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--lock               '$'\e''[[(value)]mFlag. Optional. Lock the database during dump'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--password password  '$'\e''[[(value)]mString. Optional. Password to connect'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--user user          '$'\e''[[(value)]mString. Optional. User to connect'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--host host          '$'\e''[[(value)]mString. Optional. Host to connect'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--port port          '$'\e''[[(value)]mInteger. Optional. Port to connect'$'\e''[[(reset)]m'$'\n'''$'\n''Dump a MariaDB database to raw SQL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]'$'\n'''$'\n''    --help               Flag. Optional. Display this help.'$'\n''    --print              Flag. Optional. Show the command.'$'\n''    --binary             Executable. Optional. The binary to use to do the dump. Defaults to MARIADB_BINARY_DUMP.'$'\n''    --lock               Flag. Optional. Lock the database during dump'$'\n''    --password password  String. Optional. Password to connect'$'\n''    --user user          String. Optional. User to connect'$'\n''    --host host          String. Optional. Host to connect'$'\n''    --port port          Integer. Optional. Port to connect'$'\n'''$'\n''Dump a MariaDB database to raw SQL'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/mariadb.md"
