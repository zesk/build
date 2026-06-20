#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Clean mariadb dumps of the dreaded code `/*!999999\\- enable the sandbox mode */`\n- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)\n\n'
descriptionLineCount="3"
file="bin/build/tools/mariadb.sh"
fn="mariadbDumpClean"
fnMarker="mariadbdumpclean"
foundNames=([0]="summary" [1]="stdin" [2]="stdout")
line="125"
original="mariadbDumpClean"
rawComment=$'Summary: Clean mariadb dumps for import\nClean mariadb dumps of the dreaded code `/*!999999\\- enable the sandbox mode */`\nstdin: mariadbDump\nstdout: mariadbDump (cleaned)\n- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="f7cb16e44a712948409f61ef0ce0e5762cdc356d"
sourceLine="125"
stdin=$'mariadbDump\n'
stdout=$'mariadbDump (cleaned)\n'
summary="Clean mariadb dumps for import"
summaryComputed=""
usage="mariadbDumpClean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbDumpClean'$'\e''[0m'$'\n'''$'\n''Clean mariadb dumps of the dreaded code '$'\e''[[(code)]m/'$'\e''[[(cyan)]m!999999\- enable the sandbox mode '$'\e''[[(reset)]m/'$'\e''[[(reset)]m'$'\n''- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''mariadbDump'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''mariadbDump (cleaned)'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbDumpClean'$'\n'''$'\n''Clean mariadb dumps of the dreaded code /!999999\- enable the sandbox mode /'$'\n''- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''mariadbDump'$'\n'''$'\n''Writes to stdout:'$'\n''mariadbDump (cleaned)'
documentationPath="documentation/source/tools/mariadb.md"
