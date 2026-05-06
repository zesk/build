#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - Additional packages to install"$'\n'""
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Uninstall \`php\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/php.sh"
fn="phpUninstall"
fnMarker="phpuninstall"
foundNames=([0]="argument" [1]="summary" [2]="return_code")
line="40"
rawComment="Uninstall \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Uninstall \`php\`"$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""$'\n'""
return_code="1 - If uninstallation fails"$'\n'"0 - If uninstallation succeeds"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="cd2691e7c6370ed405b6513e2b412ce1541ca05b"
sourceLine="40"
summary="Uninstall \`php\`"
summaryComputed=""
usage="phpUninstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstall '$'\e''[[(code)]mphp'$'\e''[[(reset)]m'$'\n'''$'\n''If this fails it will output the installation log.'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]mphp'$'\e''[[(reset)]m binary is no longer available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If uninstallation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If uninstallation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: phpUninstall [ package ]'$'\n'''$'\n''    package  Additional packages to install'$'\n'''$'\n''Uninstall php'$'\n'''$'\n''If this fails it will output the installation log.'$'\n'''$'\n''When this tool succeeds the php binary is no longer available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If uninstallation fails'$'\n''- 0 - If uninstallation succeeds'
documentationPath="documentation/source/tools/install.md"
