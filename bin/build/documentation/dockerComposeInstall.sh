#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="package - Additional packages to install (using \`pipInstall\`)"$'\n'""
base="docker-compose.sh"
description="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=([0]="argument" [1]="summary" [2]="return_code" [3]="see")
rawComment="Install \`docker-compose\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install (using \`pipInstall\`)"$'\n'"Summary: Install \`docker-compose\`"$'\n'"When this tool succeeds the \`docker-compose\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'"See: pipInstall"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
see="pipInstall"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1769184734"
summary="Install \`docker-compose\`"$'\n'""
usage="dockerComposeInstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install (using '$'\e''[[(code)]mpipInstall'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Install '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeInstall [ package ]'$'\n'''$'\n''    package  Additional packages to install (using pipInstall)'$'\n'''$'\n''Install docker-compose'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the docker-compose binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'$'\n'''
# elapsed 0.573
