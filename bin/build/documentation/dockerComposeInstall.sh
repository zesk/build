#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="package - Additional packages to install (using \`pipInstall\`)"$'\n'""
base="docker-compose.sh"
description="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=([0]="argument" [1]="summary" [2]="return_code" [3]="see")
rawComment="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install (using \`pipInstall\`)"$'\n'"Summary: Install \`docker-compose\`"$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'"See: pipInstall"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
see="pipInstall"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="d76bbd31ab881ad7554c01ea2d1740afa9a1a92d"
summary="Install \`docker-compose\`"$'\n'""
usage="dockerComposeInstall [ package ]"
