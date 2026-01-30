#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="package - Additional packages to install"$'\n'""
base="php.sh"
description="Uninstall \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'""
file="bin/build/tools/php.sh"
foundNames=([0]="argument" [1]="summary" [2]="return_code")
rawComment="Uninstall \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Uninstall \`php\`"$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""$'\n'""
return_code="1 - If uninstallation fails"$'\n'"0 - If uninstallation succeeds"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="f97f90ea1f46b8f2b14d5889c7debaf5d8e3000c"
summary="Uninstall \`php\`"$'\n'""
usage="phpUninstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstall '$'\e''[[(code)]mphp'$'\e''[[(reset)]m'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the '$'\e''[[(code)]mphp'$'\e''[[(reset)]m binary is no longer available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If uninstallation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If uninstallation succeeds'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mphpUninstall [[(blue)]m[ package ]'$'\n'''$'\n''    [[(blue)]mpackage  [[(value)]mAdditional packages to install'$'\n'''$'\n''Uninstall [[(code)]mphp'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the [[(code)]mphp binary is no longer available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m1 - If uninstallation fails'$'\n''- [[(code)]m0 - If uninstallation succeeds'$'\n'''
# elapsed 2.92
