#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--cache cacheDirectory - Directory. Optional. Cache directory to use for ordering work."$'\n'"finderFile - File. Required. File to reorder."$'\n'""
base="test.sh"
description="No documentation for \`testSuiteOrdering\`."$'\n'""
file="bin/build/tools/test.sh"
fn="testSuiteOrdering"
foundNames=([0]="argument" [1]="stdout")
rawComment="Argument: --cache cacheDirectory - Directory. Optional. Cache directory to use for ordering work."$'\n'"Argument: finderFile - File. Required. File to reorder."$'\n'"stdout: Reordered file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="3dc9153efc63a64f4b122dfeb5c5c0343dd405ee"
stdout="Reordered file."$'\n'""
summary="undocumented"
usage="testSuiteOrdering [ --cache cacheDirectory ] finderFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtestSuiteOrdering'$'\e''[0m '$'\e''[[(blue)]m[ --cache cacheDirectory ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfinderFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--cache cacheDirectory  '$'\e''[[(value)]mDirectory. Optional. Cache directory to use for ordering work.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfinderFile              '$'\e''[[(value)]mFile. Required. File to reorder.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]mtestSuiteOrdering'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Reordered file.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: testSuiteOrdering [ --cache cacheDirectory ] finderFile'$'\n'''$'\n''    --cache cacheDirectory  Directory. Optional. Cache directory to use for ordering work.'$'\n''    finderFile              File. Required. File to reorder.'$'\n'''$'\n''No documentation for testSuiteOrdering.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Reordered file.'$'\n'''
