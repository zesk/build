#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
description="Uninstalls \`docker-compose\`"$'\n'"stderr: Upon failure error log is output"$'\n'"Summary: Uninstall \`docker-compose\`"$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=()
rawComment="Uninstalls \`docker-compose\`"$'\n'"stderr: Upon failure error log is output"$'\n'"Summary: Uninstall \`docker-compose\`"$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="d76bbd31ab881ad7554c01ea2d1740afa9a1a92d"
summary="Uninstalls \`docker-compose\`"
usage="dockerComposeUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeUninstall'$'\e''[0m'$'\n'''$'\n''Uninstalls '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n''stderr: Upon failure error log is output'$'\n''Summary: Uninstall '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n''Return Code: 1 - If installation fails'$'\n''Return Code: 0 - If installation succeeds'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeUninstall'$'\n'''$'\n''Uninstalls docker-compose'$'\n''stderr: Upon failure error log is output'$'\n''Summary: Uninstall docker-compose'$'\n''Return Code: 1 - If installation fails'$'\n''Return Code: 0 - If installation succeeds'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.475
