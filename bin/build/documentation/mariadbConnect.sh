#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"binary - Callable. Executable to connect to the database."$'\n'"--print - Flag. Optional. Just print the statement instead of running it."$'\n'""
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Connect to a mariadb-type database using a URL"$'\n'""$'\n'""
descriptionLineCount="2"
environment="MARIADB_BINARY_CONNECT"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbConnect"
fnMarker="mariadbconnect"
foundNames=([0]="argument" [1]="environment")
line="143"
rawComment="Connect to a mariadb-type database using a URL"$'\n'"Argument: dsn - URL. Database to connect to. All arguments after this are passed to \`binary\`."$'\n'"Argument: binary - Callable. Executable to connect to the database."$'\n'"Argument: --print - Flag. Optional. Just print the statement instead of running it."$'\n'"Environment: MARIADB_BINARY_CONNECT"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="143"
summary="Connect to a mariadb-type database using a URL"
summaryComputed="true"
usage="mariadbConnect [ dsn ] [ binary ] [ --print ]"
