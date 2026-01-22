#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"binary - Callable. Executable to connect to the database."$'\n'"--print - Flag. Optional. Just print the statement instead of running it."$'\n'""
base="mariadb.sh"
description="Connect to a mariadb-type database using a URL"$'\n'""$'\n'""
environment="MARIADB_BINARY_CONNECT"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbConnect"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceModified="1769063211"
summary="Connect to a mariadb-type database using a URL"
usage="mariadbConnect [ dsn ] [ binary ] [ --print ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmariadbConnect[0m [94m[ dsn ][0m [94m[ binary ][0m [94m[ --print ][0m

    [94mdsn      [1;97mURL. Database to connect to. All arguments after this are passed to [38;2;0;255;0;48;2;0;0;0mbinary[0m.[0m
    [94mbinary   [1;97mCallable. Executable to connect to the database.[0m
    [94m--print  [1;97mFlag. Optional. Just print the statement instead of running it.[0m

Connect to a mariadb-type database using a URL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- MARIADB_BINARY_CONNECT
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbConnect [ dsn ] [ binary ] [ --print ]

    dsn      URL. Database to connect to. All arguments after this are passed to binary.
    binary   Callable. Executable to connect to the database.
    --print  Flag. Optional. Just print the statement instead of running it.

Connect to a mariadb-type database using a URL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- MARIADB_BINARY_CONNECT
- 
'
