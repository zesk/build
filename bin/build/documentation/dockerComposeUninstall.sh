#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Uninstalls `docker-compose`\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeUninstall"
fnMarker="dockercomposeuninstall"
foundNames=([0]="stderr" [1]="summary" [2]="return_code")
line="62"
original="dockerComposeUninstall"
rawComment=$'Uninstalls `docker-compose`\nstderr: Upon failure error log is output\nSummary: Uninstall `docker-compose`\nReturn Code: 1 - If installation fails\nReturn Code: 0 - If installation succeeds\n\n'
return_code=$'1 - If installation fails\n0 - If installation succeeds\n'
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="b92e02315c04b81650c815dca874d1ee5d96f43d"
sourceLine="62"
stderr=$'Upon failure error log is output\n'
summary="Uninstall \`docker-compose\`"
summaryComputed=""
usage="dockerComposeUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeUninstall'$'\e''[0m'$'\n'''$'\n''Uninstalls '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeUninstall'$'\n'''$'\n''Uninstalls docker-compose'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'
documentationPath="documentation/source/tools/install.md"
