#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="none"
base="aws.sh"
description="aws Command-Line install"$'\n'""$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'""$'\n'""
file="bin/build/tools/aws.sh"
fn="awsInstall"
foundNames=""
requires="packageInstall urlFetch"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769063211"
summary="aws Command-Line install"
usage="awsInstall"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsInstall[0m

aws Command-Line install

Installs x86 or aarch64 binary based on [38;2;0;255;0;48;2;0;0;0mHOSTTYPE[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsInstall

aws Command-Line install

Installs x86 or aarch64 binary based on HOSTTYPE.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
