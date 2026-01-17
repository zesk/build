#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="package - Additional packages to install"$'\n'""
base="php.sh"
description="Install \`php\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`php\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/php.sh"
fn="phpInstall"
foundNames=([0]="argument" [1]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/php.sh"
sourceModified="1768683825"
summary="Install \`php\`"$'\n'""
usage="phpInstall [ package ]"
