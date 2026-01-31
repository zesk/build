#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="php.sh"
description="Uninstall \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Uninstall \`php\`"$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""
file="bin/build/tools/php.sh"
foundNames=()
rawComment="Uninstall \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Uninstall \`php\`"$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="f97f90ea1f46b8f2b14d5889c7debaf5d8e3000c"
summary="Uninstall \`php\`"
usage="phpUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpUninstall'$'\e''[0m'$'\n'''$'\n''Uninstall '$'\e''[[(code)]mphp'$'\e''[[(reset)]m'$'\n''If this fails it will output the installation log.'$'\n''Argument: package - Additional packages to install'$'\n''Summary: Uninstall '$'\e''[[(code)]mphp'$'\e''[[(reset)]m'$'\n''When this tool succeeds the '$'\e''[[(code)]mphp'$'\e''[[(reset)]m binary is no longer available in the local operating system.'$'\n''Return Code: 1 - If uninstallation fails'$'\n''Return Code: 0 - If uninstallation succeeds'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: phpUninstall'$'\n'''$'\n''Uninstall php'$'\n''If this fails it will output the installation log.'$'\n''Argument: package - Additional packages to install'$'\n''Summary: Uninstall php'$'\n''When this tool succeeds the php binary is no longer available in the local operating system.'$'\n''Return Code: 1 - If uninstallation fails'$'\n''Return Code: 0 - If uninstallation succeeds'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.479
