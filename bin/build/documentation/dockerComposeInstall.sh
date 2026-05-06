#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - Additional packages to install (using \`pipInstall\`)"$'\n'""
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install \`docker-compose\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeInstall"
fnMarker="dockercomposeinstall"
foundNames=([0]="argument" [1]="summary" [2]="return_code" [3]="see")
line="37"
rawComment="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install (using \`pipInstall\`)"$'\n'"Summary: Install \`docker-compose\`"$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'"See: pipInstall"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
see="pipInstall"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="fd46ba45b4bfb981e0a17b3510aa593d2fe8dec6"
sourceLine="37"
summary="Install \`docker-compose\`"
summaryComputed=""
usage="dockerComposeInstall [ package ]"
