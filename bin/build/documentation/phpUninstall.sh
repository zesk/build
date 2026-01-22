#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="package - Additional packages to install"$'\n'""
base="php.sh"
description="Uninstall \`php\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`php\` binary is no longer available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""
file="bin/build/tools/php.sh"
fn="phpUninstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceModified="1768759583"
summary="Uninstall \`php\`"$'\n'""
usage="phpUninstall [ package ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mphpUninstall[0m [94m[ package ][0m

    [94mpackage  [1;97mAdditional packages to install[0m

Uninstall [38;2;0;255;0;48;2;0;0;0mphp[0m

If this fails it will output the installation log.

When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mphp[0m binary is no longer available in the local operating system.
Return Code: 1 - If uninstallation fails
Return Code: 0 - If uninstallation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: phpUninstall [ package ]

    package  Additional packages to install

Uninstall php

If this fails it will output the installation log.

When this tool succeeds the php binary is no longer available in the local operating system.
Return Code: 1 - If uninstallation fails
Return Code: 0 - If uninstallation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
