#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--print - Flag. Optional. Show the command."$'\n'"--binary - Executable. Optional. The binary to use to do the dump. Defaults to \`MARIADB_BINARY_DUMP\`."$'\n'"--lock - Flag. Optional. Lock the database during dump"$'\n'"--password password - String. Optional. Password to connect"$'\n'"--user user - String. Optional. User to connect"$'\n'"--host host - String. Optional. Host to connect"$'\n'"--port port - Integer. Optional. Port to connect"$'\n'""
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Dump a MariaDB database to raw SQL"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/mariadb.sh"
fn="mariadbDump"
fnMarker="mariadbdump"
foundNames=([0]="argument")
line="53"
rawComment="Dump a MariaDB database to raw SQL"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --print - Flag. Optional. Show the command."$'\n'"Argument: --binary - Executable. Optional. The binary to use to do the dump. Defaults to \`MARIADB_BINARY_DUMP\`."$'\n'"Argument: --lock - Flag. Optional. Lock the database during dump"$'\n'"Argument: --password password - String. Optional. Password to connect"$'\n'"Argument: --user user - String. Optional. User to connect"$'\n'"Argument: --host host - String. Optional. Host to connect"$'\n'"Argument: --port port - Integer. Optional. Port to connect"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="53"
summary="Dump a MariaDB database to raw SQL"
summaryComputed="true"
usage="mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]"
