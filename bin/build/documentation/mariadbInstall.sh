#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="none"
base="mariadb.sh"
description="Install \`mariadb\`"$'\n'""$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceModified="1769063211"
summary="Install \`mariadb\`"
usage="mariadbInstall"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmariadbInstall[0m

Install [38;2;0;255;0;48;2;0;0;0mmariadb[0m

When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mmariadb[0m binary is available in the local operating system.
Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbInstall

Install mariadb

When this tool succeeds the mariadb binary is available in the local operating system.
Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
