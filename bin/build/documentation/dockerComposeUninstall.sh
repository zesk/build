#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
description="Uninstalls \`docker-compose\`"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeUninstall"
foundNames=([0]="stderr" [1]="summary" [2]="return_code")
rawComment="Uninstalls \`docker-compose\`"$'\n'"stderr: Upon failure error log is output"$'\n'"Summary: Uninstall \`docker-compose\`"$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="2b8b33a878ab55849ee3b515c1d66630e3b166aa"
stderr="Upon failure error log is output"$'\n'""
summary="Uninstall \`docker-compose\`"$'\n'""
usage="dockerComposeUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeUninstall'$'\e''[0m'$'\n'''$'\n''Uninstalls '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeUninstall'$'\n'''$'\n''Uninstalls docker-compose'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'$'\n'''
