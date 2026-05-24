#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Fetch the binary name for the default package in a group\nGroups are:\n- mysql\n- mysqldump\n\n'
descriptionLineCount="5"
file="bin/build/tools/package.sh"
fn="packageDefault"
fnMarker="packagedefault"
foundNames=()
line="175"
rawComment=$'Fetch the binary name for the default package in a group\nGroups are:\n- mysql\n- mysqldump\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="175"
summary="Fetch the binary name for the default package in a"
summaryComputed="true"
usage="packageDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageDefault'$'\e''[0m'$'\n'''$'\n''Fetch the binary name for the default package in a group'$'\n''Groups are:'$'\n''- mysql'$'\n''- mysqldump'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageDefault'$'\n'''$'\n''Fetch the binary name for the default package in a group'$'\n''Groups are:'$'\n''- mysql'$'\n''- mysqldump'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
