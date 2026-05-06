#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/mariadb.sh"
fn="mariadbDumpClean"
fnMarker="mariadbdumpclean"
foundNames=([0]="summary" [1]="stdin" [2]="stdout")
line="125"
rawComment="Summary: Clean mariadb dumps for import"$'\n'"Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"stdin: mariadbDump"$'\n'"stdout: mariadbDump (cleaned)"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="125"
stdin="mariadbDump"$'\n'""
stdout="mariadbDump (cleaned)"$'\n'""
summary="Clean mariadb dumps for import"
summaryComputed=""
usage="mariadbDumpClean"
