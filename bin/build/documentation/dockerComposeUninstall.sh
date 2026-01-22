#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="none"
base="docker-compose.sh"
description="Uninstalls \`docker-compose\`"$'\n'""$'\n'""$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeUninstall"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1768721469"
stderr="Upon failure error log is output"$'\n'""
summary="Uninstall \`docker-compose\`"$'\n'""
usage="dockerComposeUninstall"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerComposeUninstall[0m

Uninstalls [38;2;0;255;0;48;2;0;0;0mdocker-compose[0m


Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeUninstall

Uninstalls docker-compose


Return Code: 1 - If installation fails
Return Code: 0 - If installation succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
