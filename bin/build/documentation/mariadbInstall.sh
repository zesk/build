#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
description="Install \`mariadb\`"$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/mariadb.sh"
foundNames=()
rawComment="Install \`mariadb\`"$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="0a776c97099118ca512ea3c6ad48d1bd2f22b075"
summary="Install \`mariadb\`"
usage="mariadbInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbInstall'$'\e''[0m'$'\n'''$'\n''Install '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m'$'\n''When this tool succeeds the '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n''Return Code: 1 - If installation fails'$'\n''Return Code: 0 - If installation succeeds'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mariadbInstall'$'\n'''$'\n''Install mariadb'$'\n''When this tool succeeds the mariadb binary is available in the local operating system.'$'\n''Return Code: 1 - If installation fails'$'\n''Return Code: 0 - If installation succeeds'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.448
