#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
description="Install \`mariadb\`"$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbInstall"
foundNames=([0]="return_code")
line="16"
lowerFn="mariadbinstall"
rawComment="Install \`mariadb\`"$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="16"
summary="Install \`mariadb\`"
summaryComputed="true"
usage="mariadbInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbInstall'$'\e''[0m'$'\n'''$'\n''Install '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m'$'\n''When this tool succeeds the '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mariadbInstall'$'\n'''$'\n''Install mariadb'$'\n''When this tool succeeds the mariadb binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'$'\n'''
documentationPath="documentation/source/tools/install.md"
