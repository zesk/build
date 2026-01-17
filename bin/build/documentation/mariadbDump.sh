#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--print -  Flag. Optional.Show the command."$'\n'"--binary -  Executable. Optional.The binary to use to do the dump. Defaults to \`MARIADB_BINARY_DUMP\`."$'\n'"--lock -  Flag. Optional.Lock the database during dump"$'\n'"--password password - String. Optional. Password to connect"$'\n'"--user user - String. Optional. User to connect"$'\n'"--host host - String. Optional. Host to connect"$'\n'"--port port -  Integer. Optional.Port to connect"$'\n'""
base="mariadb.sh"
description="Dump a MariaDB database to raw SQL"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbDump"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/mariadb.sh"
sourceModified="1768683825"
summary="Dump a MariaDB database to raw SQL"
usage="mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]"
