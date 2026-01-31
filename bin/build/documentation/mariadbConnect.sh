#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
description="Connect to a mariadb-type database using a URL"$'\n'"Argument: dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"Argument: binary - Callable. Executable to connect to the database."$'\n'"Argument: --print - Flag. Optional. Just print the statement instead of running it."$'\n'"Environment: MARIADB_BINARY_CONNECT"$'\n'""
file="bin/build/tools/mariadb.sh"
foundNames=()
rawComment="Connect to a mariadb-type database using a URL"$'\n'"Argument: dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"Argument: binary - Callable. Executable to connect to the database."$'\n'"Argument: --print - Flag. Optional. Just print the statement instead of running it."$'\n'"Environment: MARIADB_BINARY_CONNECT"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="0a776c97099118ca512ea3c6ad48d1bd2f22b075"
summary="Connect to a mariadb-type database using a URL"
usage="mariadbConnect"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbConnect'$'\e''[0m'$'\n'''$'\n''Connect to a mariadb-type database using a URL'$'\n''Argument: dsn - URL. Database to connect to. All arguments after this are passed to '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\n''Argument: binary - Callable. Executable to connect to the database.'$'\n''Argument: --print - Flag. Optional. Just print the statement instead of running it.'$'\n''Environment: MARIADB_BINARY_CONNECT'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mariadbConnect'$'\n'''$'\n''Connect to a mariadb-type database using a URL'$'\n''Argument: dsn - URL. Database to connect to. All arguments after this are passed to binary.'$'\n''Argument: binary - Callable. Executable to connect to the database.'$'\n''Argument: --print - Flag. Optional. Just print the statement instead of running it.'$'\n''Environment: MARIADB_BINARY_CONNECT'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.464
