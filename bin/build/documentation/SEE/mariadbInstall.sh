#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install \`mariadb\`"$'\n'""$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/mariadb.sh"
fn="mariadbInstall"
fnMarker="mariadbinstall"
foundNames=([0]="return_code")
line="16"
rawComment="Install \`mariadb\`"$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="16"
summary="Install \`mariadb\`"
summaryComputed="true"
usage="mariadbInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbInstall'$'\e''[0m'$'\n'''$'\n''Install '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbInstall'$'\n'''$'\n''Install mariadb'$'\n'''$'\n''When this tool succeeds the mariadb binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'
documentationPath="documentation/source/tools/install.md"
