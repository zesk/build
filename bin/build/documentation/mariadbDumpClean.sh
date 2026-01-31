#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
description="Summary: Clean mariadb dumps for import"$'\n'"Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"stdin: mariadbDump"$'\n'"stdout: mariadbDump (cleaned)"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""
file="bin/build/tools/mariadb.sh"
foundNames=()
rawComment="Summary: Clean mariadb dumps for import"$'\n'"Clean mariadb dumps of the dreaded code \`/*!999999\\- enable the sandbox mode */\`"$'\n'"stdin: mariadbDump"$'\n'"stdout: mariadbDump (cleaned)"$'\n'"- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="0a776c97099118ca512ea3c6ad48d1bd2f22b075"
summary="Summary: Clean mariadb dumps for import"
usage="mariadbDumpClean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbDumpClean'$'\e''[0m'$'\n'''$'\n''Summary: Clean mariadb dumps for import'$'\n''Clean mariadb dumps of the dreaded code '$'\e''[[(code)]m/'$'\e''[[(cyan)]m!999999\- enable the sandbox mode '$'\e''[[(reset)]m/'$'\e''[[(reset)]m'$'\n''stdin: mariadbDump'$'\n''stdout: mariadbDump (cleaned)'$'\n''- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mariadbDumpClean'$'\n'''$'\n''Summary: Clean mariadb dumps for import'$'\n''Clean mariadb dumps of the dreaded code /!999999\- enable the sandbox mode /'$'\n''stdin: mariadbDump'$'\n''stdout: mariadbDump (cleaned)'$'\n''- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.441
