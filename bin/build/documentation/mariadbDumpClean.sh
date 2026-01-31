#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
description="Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""
file="bin/build/tools/mariadb.sh"
foundNames=([0]="summary" [1]="stdin" [2]="stdout")
rawComment="Summary: Clean mariadb dumps for import"$'\n'"Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"stdin: mariadbDump"$'\n'"stdout: mariadbDump (cleaned)"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="0a776c97099118ca512ea3c6ad48d1bd2f22b075"
stdin="mariadbDump"$'\n'""
stdout="mariadbDump (cleaned)"$'\n'""
summary="Clean mariadb dumps for import"$'\n'""
usage="mariadbDumpClean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbDumpClean'$'\e''[0m'$'\n'''$'\n''Clean mariadb dumps of the dreaded code '$'\e''[[(code)]m/'$'\e''[[(cyan)]m!999999\- enable the sandbox mode '$'\e''[[(reset)]m/'$'\e''[[(reset)]m'$'\n''- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''mariadbDump'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''mariadbDump (cleaned)'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mmariadbDumpClean'$'\n'''$'\n''Clean mariadb dumps of the dreaded code [[(code)]m/[[(cyan)]m!999999\- enable the sandbox mode /'$'\n''- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Reads from [[(code)]mstdin:'$'\n''mariadbDump'$'\n'''$'\n''Writes to [[(code)]mstdout:'$'\n''mariadbDump (cleaned)'$'\n'''
# elapsed 4.044
