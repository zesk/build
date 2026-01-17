#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="package - Additional packages to install (using \`pipInstall\`)"$'\n'""
base="docker-compose.sh"
description="Install \`docker-compose\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeInstall"
foundNames=([0]="argument" [1]="summary" [2]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="pipInstall"$'\n'""
source="bin/build/tools/docker-compose.sh"
sourceModified="1768683825"
summary="Install \`docker-compose\`"$'\n'""
usage="dockerComposeInstall [ package ]"
