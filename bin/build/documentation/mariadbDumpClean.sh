#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="none"
base="mariadb.sh"
description="Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbDumpClean"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceModified="1769063211"
stdin="mariadbDump"$'\n'""
stdout="mariadbDump (cleaned)"$'\n'""
summary="Clean mariadb dumps for import"$'\n'""
usage="mariadbDumpClean"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmariadbDumpClean[0m

Clean mariadb dumps of the dreaded code [38;2;0;255;0;48;2;0;0;0m/[36m!999999\- enable the sandbox mode [0m/[0m
- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
mariadbDump

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
mariadbDump (cleaned)
'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbDumpClean

Clean mariadb dumps of the dreaded code /!999999\- enable the sandbox mode /
- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
mariadbDump

Writes to stdout:
mariadbDump (cleaned)
'
