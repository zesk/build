#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'indexPath - Directory. Required. Index path.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List functions without documentation pages.\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIndexUnlinkedFunctions"
fnMarker="documentationindexunlinkedfunctions"
foundNames=([0]="argument")
line="418"
original="documentationIndexUnlinkedFunctions"
rawComment=$'List functions without documentation pages.\nArgument: indexPath - Directory. Required. Index path.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="95bb594086eeaa10ba59684f31d888e7da217309"
sourceLine="418"
summary="List functions without documentation pages."
summaryComputed="true"
usage="documentationIndexUnlinkedFunctions indexPath [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIndexUnlinkedFunctions'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mindexPath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mindexPath  '$'\e''[[(value)]mDirectory. Required. Index path.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List functions without documentation pages.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexUnlinkedFunctions indexPath [ --help ]'$'\n'''$'\n''    indexPath  Directory. Required. Index path.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''List functions without documentation pages.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
