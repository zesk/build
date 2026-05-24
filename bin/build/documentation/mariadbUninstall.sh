#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Uninstall `mariadb`\n\nWhen this tool succeeds the `mariadb` binary will no longer be available in the local operating system.\n\n'
descriptionLineCount="4"
file="bin/build/tools/mariadb.sh"
fn="mariadbUninstall"
fnMarker="mariadbuninstall"
foundNames=([0]="return_code")
line="32"
rawComment=$'Uninstall `mariadb`\nWhen this tool succeeds the `mariadb` binary will no longer be available in the local operating system.\nReturn Code: 1 - If uninstallation fails\nReturn Code: 0 - If uninstallation succeeds\n\n'
return_code=$'1 - If uninstallation fails\n0 - If uninstallation succeeds\n'
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="32"
summary="Uninstall \`mariadb\`"
summaryComputed="true"
usage="mariadbUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmariadbUninstall'$'\e''[0m'$'\n'''$'\n''Uninstall '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m binary will no longer be available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If uninstallation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If uninstallation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbUninstall'$'\n'''$'\n''Uninstall mariadb'$'\n'''$'\n''When this tool succeeds the mariadb binary will no longer be available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If uninstallation fails'$'\n''- 0 - If uninstallation succeeds'
documentationPath="documentation/source/tools/install.md"
