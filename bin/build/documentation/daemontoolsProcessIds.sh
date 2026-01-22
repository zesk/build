#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="none"
base="daemontools.sh"
description="List any processes associated with daemontools supervisors"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsProcessIds"
requires="pgrep read printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1768769644"
summary="List any processes associated with daemontools supervisors"
usage="daemontoolsProcessIds"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdaemontoolsProcessIds[0m

List any processes associated with daemontools supervisors

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsProcessIds

List any processes associated with daemontools supervisors

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
