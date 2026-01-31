#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
description="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install (using \`pipInstall\`)"$'\n'"Summary: Install \`docker-compose\`"$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'"See: pipInstall"$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=()
rawComment="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install (using \`pipInstall\`)"$'\n'"Summary: Install \`docker-compose\`"$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'"See: pipInstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="d76bbd31ab881ad7554c01ea2d1740afa9a1a92d"
summary="Install \`docker-compose\`"
usage="dockerComposeInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeInstall'$'\e''[0m'$'\n'''$'\n''Install '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n''If this fails it will output the installation log.'$'\n''Argument: package - Additional packages to install (using '$'\e''[[(code)]mpipInstall'$'\e''[[(reset)]m)'$'\n''Summary: Install '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n''When this tool succeeds the '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n''Return Code: 1 - If installation fails'$'\n''Return Code: 0 - If installation succeeds'$'\n''See: pipInstall'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeInstall'$'\n'''$'\n''Install docker-compose'$'\n''If this fails it will output the installation log.'$'\n''Argument: package - Additional packages to install (using pipInstall)'$'\n''Summary: Install docker-compose'$'\n''When this tool succeeds the docker-compose binary is available in the local operating system.'$'\n''Return Code: 1 - If installation fails'$'\n''Return Code: 0 - If installation succeeds'$'\n''See: pipInstall'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.48
