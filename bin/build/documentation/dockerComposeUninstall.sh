#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Uninstalls \`docker-compose\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeUninstall"
fnMarker="dockercomposeuninstall"
foundNames=([0]="stderr" [1]="summary" [2]="return_code")
line="62"
rawComment="Uninstalls \`docker-compose\`"$'\n'"stderr: Upon failure error log is output"$'\n'"Summary: Uninstall \`docker-compose\`"$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="a10cd9abf0ca14f427ce8a440b925933d82759e8"
sourceLine="62"
stderr="Upon failure error log is output"$'\n'""
summary="Uninstall \`docker-compose\`"
summaryComputed=""
usage="dockerComposeUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeUninstall'$'\e''[0m'$'\n'''$'\n''Uninstalls '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeUninstall'$'\n'''$'\n''Uninstalls docker-compose'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'
documentationPath="documentation/source/tools/install.md"
