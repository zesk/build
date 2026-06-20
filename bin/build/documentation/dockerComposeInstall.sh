#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'package - Additional packages to install (using `pipInstall`)\n'
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install `docker-compose`\n\nIf this fails it will output the installation log.\n\nWhen this tool succeeds the `docker-compose` binary is available in the local operating system.\n\n'
descriptionLineCount="6"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeInstall"
fnMarker="dockercomposeinstall"
foundNames=([0]="argument" [1]="summary" [2]="return_code" [3]="see")
line="37"
original="dockerComposeInstall"
rawComment=$'Install `docker-compose`\nIf this fails it will output the installation log.\nArgument: package - Additional packages to install (using `pipInstall`)\nSummary: Install `docker-compose`\nWhen this tool succeeds the `docker-compose` binary is available in the local operating system.\nReturn Code: 1 - If installation fails\nReturn Code: 0 - If installation succeeds\nSee: pipInstall\n\n'
return_code=$'1 - If installation fails\n0 - If installation succeeds\n'
see=$'pipInstall\n'
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="b92e02315c04b81650c815dca874d1ee5d96f43d"
sourceLine="37"
summary="Install \`docker-compose\`"
summaryComputed=""
usage="dockerComposeInstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install (using '$'\e''[[(code)]mpipInstall'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Install '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m'$'\n'''$'\n''If this fails it will output the installation log.'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeInstall [ package ]'$'\n'''$'\n''    package  Additional packages to install (using pipInstall)'$'\n'''$'\n''Install docker-compose'$'\n'''$'\n''If this fails it will output the installation log.'$'\n'''$'\n''When this tool succeeds the docker-compose binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'
documentationPath="documentation/source/tools/install.md"
