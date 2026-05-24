#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'package - Additional packages to install\n'
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install `php`\n\nIf this fails it will output the installation log.\n\nWhen this tool succeeds the `php` binary is available in the local operating system.\n\n'
descriptionLineCount="6"
file="bin/build/tools/php.sh"
fn="phpInstall"
fnMarker="phpinstall"
foundNames=([0]="argument" [1]="summary" [2]="return_code")
line="21"
rawComment=$'Install `php`\nIf this fails it will output the installation log.\nArgument: package - Additional packages to install\nSummary: Install `php`\nWhen this tool succeeds the `php` binary is available in the local operating system.\nReturn Code: 1 - If installation fails\nReturn Code: 0 - If installation succeeds\n\n'
return_code=$'1 - If installation fails\n0 - If installation succeeds\n'
sourceFile="bin/build/tools/php.sh"
sourceHash="cd2691e7c6370ed405b6513e2b412ce1541ca05b"
sourceLine="21"
summary="Install \`php\`"
summaryComputed=""
usage="phpInstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install'$'\e''[[(reset)]m'$'\n'''$'\n''Install '$'\e''[[(code)]mphp'$'\e''[[(reset)]m'$'\n'''$'\n''If this fails it will output the installation log.'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]mphp'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: phpInstall [ package ]'$'\n'''$'\n''    package  Additional packages to install'$'\n'''$'\n''Install php'$'\n'''$'\n''If this fails it will output the installation log.'$'\n'''$'\n''When this tool succeeds the php binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'
documentationPath="documentation/source/tools/install.md"
