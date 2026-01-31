#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"binary - Callable. Executable to connect to the database."$'\n'"--print - Flag. Optional. Just print the statement instead of running it."$'\n'""
base="mariadb.sh"
description="Connect to a mariadb-type database using a URL"$'\n'""
environment="MARIADB_BINARY_CONNECT"$'\n'""
file="bin/build/tools/mariadb.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Connect to a mariadb-type database using a URL"$'\n'"Argument: dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"Argument: binary - Callable. Executable to connect to the database."$'\n'"Argument: --print - Flag. Optional. Just print the statement instead of running it."$'\n'"Environment: MARIADB_BINARY_CONNECT"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="0a776c97099118ca512ea3c6ad48d1bd2f22b075"
summary="Connect to a mariadb-type database using a URL"
summaryComputed="true"
usage="mariadbConnect [ dsn ] [ binary ] [ --print ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbConnect'$'\e''[0m '$'\e''[[(blue)]m[ dsn ]'$'\e''[0m '$'\e''[[(blue)]m[ binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --print ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdsn      '$'\e''[[(value)]mURL. Database to connect to. All arguments after this are passed to '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mbinary   '$'\e''[[(value)]mCallable. Executable to connect to the database.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--print  '$'\e''[[(value)]mFlag. Optional. Just print the statement instead of running it.'$'\e''[[(reset)]m'$'\n'''$'\n''Connect to a mariadb-type database using a URL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- MARIADB_BINARY_CONNECT'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mmariadbConnect [ dsn ] [ binary ] [ --print ]'$'\n'''$'\n''    dsn      [[(value)]mURL. Database to connect to. All arguments after this are passed to [[(code)]mbinary.'$'\n''    binary   [[(value)]mCallable. Executable to connect to the database.'$'\n''    --print  [[(value)]mFlag. Optional. Just print the statement instead of running it.'$'\n'''$'\n''Connect to a mariadb-type database using a URL'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- MARIADB_BINARY_CONNECT'$'\n'''
# elapsed 4.404
