#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="none"
base="package.sh"
description="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'""
file="bin/build/tools/package.sh"
fn="packageManagerDefault"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="platform"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1769063211"
summary="Determine the default package manager on this platform."
usage="packageManagerDefault"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageManagerDefault[0m

Determine the default package manager on this platform.
Output is one of:
- apk apt brew port

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerDefault

Determine the default package manager on this platform.
Output is one of:
- apk apt brew port

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
