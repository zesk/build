#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'lastVersion - String. Required. Version to calculate the next minor version.\n'
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1\n\n'
descriptionLineCount="2"
file="bin/build/tools/version.sh"
fn="versionNextMinor"
fnMarker="versionnextminor"
foundNames=([0]="argument")
line="199"
rawComment=$'Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1\nArgument: lastVersion - String. Required. Version to calculate the next minor version.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/version.sh"
sourceHash="cb6d9642368b7b2c276fb293b83d8e5124812afb"
sourceLine="199"
summary="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"
summaryComputed="true"
usage="versionNextMinor lastVersion"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mversionNextMinor'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlastVersion'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlastVersion  '$'\e''[[(value)]mString. Required. Version to calculate the next minor version.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: versionNextMinor lastVersion'$'\n'''$'\n''    lastVersion  String. Required. Version to calculate the next minor version.'$'\n'''$'\n''Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/version.md"
