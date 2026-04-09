#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
description="Uninstalls \`docker-compose\`"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeUninstall"
foundNames=([0]="stderr" [1]="summary" [2]="return_code")
line="62"
lowerFn="dockercomposeuninstall"
rawComment="Uninstalls \`docker-compose\`"$'\n'"stderr: Upon failure error log is output"$'\n'"Summary: Uninstall \`docker-compose\`"$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="a21ed1c073769da3a59ec67f35a55a8a1d7d14ec"
sourceLine="62"
stderr="Upon failure error log is output"$'\n'""
summary="Uninstall \`docker-compose\`"$'\n'""
usage="dockerComposeUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeUninstall'$'\e''[0m'$'\n'''$'\n''Uninstalls '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeUninstall'$'\n'''$'\n''Uninstalls docker-compose'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'$'\n'''
documentationPath="documentation/source/tools/install.md"
