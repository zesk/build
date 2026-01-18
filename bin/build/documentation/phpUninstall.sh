#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="package - Additional packages to install"$'\n'""
base="php.sh"
description="Uninstall \`php\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""
file="bin/build/tools/php.sh"
fn="phpUninstall"
foundNames=([0]="argument" [1]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/php.sh"
sourceModified="1768695708"
summary="Uninstall \`php\`"$'\n'""
usage="phpUninstall [ package ]"
