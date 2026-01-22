#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="package - Additional packages to install"$'\n'""
base="php.sh"
description="Install \`php\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`php\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/php.sh"
fn="phpInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceModified="1768759583"
summary="Install \`php\`"$'\n'""
usage="phpInstall [ package ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mphpInstall[0m [94m[ package ][0m

    [94mpackage  [1;97mAdditional packages to install[0m

Install [38;2;0;255;0;48;2;0;0;0mphp[0m

If this fails it will output the installation log.

When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mphp[0m binary is available in the local operating system.
Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: phpInstall [ package ]

    package  Additional packages to install

Install php

If this fails it will output the installation log.

When this tool succeeds the php binary is available in the local operating system.
Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
