#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="none"
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs the path to the PHP log file\n\n'
descriptionLineCount="2"
file="bin/build/tools/php.sh"
fn="phpLog"
fnMarker="phplog"
foundNames=()
line="76"
rawComment=$'Outputs the path to the PHP log file\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/php.sh"
sourceHash="378499878da6ebea46229658d82d5ab6d4d07b85"
sourceLine="76"
summary="Outputs the path to the PHP log file"
summaryComputed="true"
usage="phpLog"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpLog'$'\e''[0m'$'\n'''$'\n''Outputs the path to the PHP log file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: phpLog'$'\n'''$'\n''Outputs the path to the PHP log file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/php.md"
