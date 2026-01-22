#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--print - Flag. Optional. Show the command."$'\n'"--binary - Executable. Optional. The binary to use to do the dump. Defaults to \`MARIADB_BINARY_DUMP\`."$'\n'"--lock - Flag. Optional. Lock the database during dump"$'\n'"--password password - String. Optional. Password to connect"$'\n'"--user user - String. Optional. User to connect"$'\n'"--host host - String. Optional. Host to connect"$'\n'"--port port - Integer. Optional. Port to connect"$'\n'""
base="mariadb.sh"
description="Dump a MariaDB database to raw SQL"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbDump"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceModified="1768756695"
summary="Dump a MariaDB database to raw SQL"
usage="mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmariadbDump[0m [94m[ --help ][0m [94m[ --print ][0m [94m[ --binary ][0m [94m[ --lock ][0m [94m[ --password password ][0m [94m[ --user user ][0m [94m[ --host host ][0m [94m[ --port port ][0m

    [94m--help               [1;97mFlag. Optional. Display this help.[0m
    [94m--print              [1;97mFlag. Optional. Show the command.[0m
    [94m--binary             [1;97mExecutable. Optional. The binary to use to do the dump. Defaults to [38;2;0;255;0;48;2;0;0;0mMARIADB_BINARY_DUMP[0m.[0m
    [94m--lock               [1;97mFlag. Optional. Lock the database during dump[0m
    [94m--password password  [1;97mString. Optional. Password to connect[0m
    [94m--user user          [1;97mString. Optional. User to connect[0m
    [94m--host host          [1;97mString. Optional. Host to connect[0m
    [94m--port port          [1;97mInteger. Optional. Port to connect[0m

Dump a MariaDB database to raw SQL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]

    --help               Flag. Optional. Display this help.
    --print              Flag. Optional. Show the command.
    --binary             Executable. Optional. The binary to use to do the dump. Defaults to MARIADB_BINARY_DUMP.
    --lock               Flag. Optional. Lock the database during dump
    --password password  String. Optional. Password to connect
    --user user          String. Optional. User to connect
    --host host          String. Optional. Host to connect
    --port port          Integer. Optional. Port to connect

Dump a MariaDB database to raw SQL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
