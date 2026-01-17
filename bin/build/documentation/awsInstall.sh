#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="none"
base="aws.sh"
description="aws Command-Line install"$'\n'""$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'""$'\n'""
file="bin/build/tools/aws.sh"
fn="awsInstall"
foundNames=([0]="requires")
requires="packageInstall urlFetch"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768683999"
summary="aws Command-Line install"
usage="awsInstall"
