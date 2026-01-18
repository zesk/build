#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"binary - Callable. Executable to connect to the database."$'\n'"--print - Flag. Optional. Just print the statement instead of running it."$'\n'""
base="mariadb.sh"
description="Connect to a mariadb-type database using a URL"$'\n'""$'\n'""
environment="MARIADB_BINARY_CONNECT"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbConnect"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/mariadb.sh"
sourceModified="1768756695"
summary="Connect to a mariadb-type database using a URL"
usage="mariadbConnect [ dsn ] [ binary ] [ --print ]"
