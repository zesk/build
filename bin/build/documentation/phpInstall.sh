#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="package - Additional packages to install"$'\n'""
base="php.sh"
description="Install \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`php\` binary is available in the local operating system."$'\n'""
file="bin/build/tools/php.sh"
foundNames=([0]="argument" [1]="summary" [2]="return_code")
rawComment="Install \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Install \`php\`"$'\n'"When this tool succeeds the \`php\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceModified="1769324125"
summary="Install \`php\`"$'\n'""
usage="phpInstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install'$'\e''[[(reset)]m'$'\n'''$'\n''Install '$'\e''[[(code)]mphp'$'\e''[[(reset)]m'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the '$'\e''[[(code)]mphp'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: phpInstall [ package ]'$'\n'''$'\n''    package  Additional packages to install'$'\n'''$'\n''Install php'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the php binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'$'\n'''
# elapsed 0.54
