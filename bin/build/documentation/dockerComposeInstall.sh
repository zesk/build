#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="package - Additional packages to install (using \`pipInstall\`)"$'\n'""
base="docker-compose.sh"
description="Install \`docker-compose\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="pipInstall"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1768721469"
summary="Install \`docker-compose\`"$'\n'""
usage="dockerComposeInstall [ package ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerComposeInstall[0m [94m[ package ][0m

    [94mpackage  [1;97mAdditional packages to install (using [38;2;0;255;0;48;2;0;0;0mpipInstall[0m)[0m

Install [38;2;0;255;0;48;2;0;0;0mdocker-compose[0m

If this fails it will output the installation log.

When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mdocker-compose[0m binary is available in the local operating system.
Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeInstall [ package ]

    package  Additional packages to install (using pipInstall)

Install docker-compose

If this fails it will output the installation log.

When this tool succeeds the docker-compose binary is available in the local operating system.
Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
