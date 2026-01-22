#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mariadb.sh"
argument="none"
base="mariadb.sh"
description="Uninstall \`mariadb\`"$'\n'""$'\n'"When this tool succeeds the \`mariadb\` binary will no longer be available in the local operating system."$'\n'"Return Code: 1 - If uninstallation fails"$'\n'"Return Code: 0 - If uninstallation succeeds"$'\n'""
file="bin/build/tools/mariadb.sh"
fn="mariadbUninstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceModified="1768756695"
summary="Uninstall \`mariadb\`"
usage="mariadbUninstall"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmariadbUninstall[0m

Uninstall [38;2;0;255;0;48;2;0;0;0mmariadb[0m

When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mmariadb[0m binary will no longer be available in the local operating system.
Return Code: 1 - If uninstallation fails
Return Code: 0 - If uninstallation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mariadbUninstall

Uninstall mariadb

When this tool succeeds the mariadb binary will no longer be available in the local operating system.
Return Code: 1 - If uninstallation fails
Return Code: 0 - If uninstallation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
