#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
description="Dump a MariaDB database to raw SQL"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --print - Flag. Optional. Show the command."$'\n'"Argument: --binary - Executable. Optional. The binary to use to do the dump. Defaults to \`MARIADB_BINARY_DUMP\`."$'\n'"Argument: --lock - Flag. Optional. Lock the database during dump"$'\n'"Argument: --password password - String. Optional. Password to connect"$'\n'"Argument: --user user - String. Optional. User to connect"$'\n'"Argument: --host host - String. Optional. Host to connect"$'\n'"Argument: --port port - Integer. Optional. Port to connect"$'\n'""
file="bin/build/tools/mariadb.sh"
foundNames=()
rawComment="Dump a MariaDB database to raw SQL"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --print - Flag. Optional. Show the command."$'\n'"Argument: --binary - Executable. Optional. The binary to use to do the dump. Defaults to \`MARIADB_BINARY_DUMP\`."$'\n'"Argument: --lock - Flag. Optional. Lock the database during dump"$'\n'"Argument: --password password - String. Optional. Password to connect"$'\n'"Argument: --user user - String. Optional. User to connect"$'\n'"Argument: --host host - String. Optional. Host to connect"$'\n'"Argument: --port port - Integer. Optional. Port to connect"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="0a776c97099118ca512ea3c6ad48d1bd2f22b075"
summary="Dump a MariaDB database to raw SQL"
usage="mariadbDump"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbDump'$'\e''[0m'$'\n'''$'\n''Dump a MariaDB database to raw SQL'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --print - Flag. Optional. Show the command.'$'\n''Argument: --binary - Executable. Optional. The binary to use to do the dump. Defaults to '$'\e''[[(code)]mMARIADB_BINARY_DUMP'$'\e''[[(reset)]m.'$'\n''Argument: --lock - Flag. Optional. Lock the database during dump'$'\n''Argument: --password password - String. Optional. Password to connect'$'\n''Argument: --user user - String. Optional. User to connect'$'\n''Argument: --host host - String. Optional. Host to connect'$'\n''Argument: --port port - Integer. Optional. Port to connect'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mariadbDump'$'\n'''$'\n''Dump a MariaDB database to raw SQL'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --print - Flag. Optional. Show the command.'$'\n''Argument: --binary - Executable. Optional. The binary to use to do the dump. Defaults to MARIADB_BINARY_DUMP.'$'\n''Argument: --lock - Flag. Optional. Lock the database during dump'$'\n''Argument: --password password - String. Optional. Password to connect'$'\n''Argument: --user user - String. Optional. User to connect'$'\n''Argument: --host host - String. Optional. Host to connect'$'\n''Argument: --port port - Integer. Optional. Port to connect'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.443
