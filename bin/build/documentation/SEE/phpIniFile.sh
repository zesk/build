#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs the path to the PHP ini file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/php.sh"
fn="phpIniFile"
fnMarker="phpinifile"
foundNames=()
line="90"
rawComment="Outputs the path to the PHP ini file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="cd2691e7c6370ed405b6513e2b412ce1541ca05b"
sourceLine="90"
summary="Outputs the path to the PHP ini file"
summaryComputed="true"
usage="phpIniFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpIniFile'$'\e''[0m'$'\n'''$'\n''Outputs the path to the PHP ini file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: phpIniFile'$'\n'''$'\n''Outputs the path to the PHP ini file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/php.md"
