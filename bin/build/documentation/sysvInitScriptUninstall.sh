#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sysvinit.sh"
argument="binary - String. Required. Basename of installed script to remove."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="sysvinit.sh"
description="Remove an initialization script"$'\n'""
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptUninstall"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sysvinit.sh"
sourceModified="1768683999"
summary="Remove an initialization script"
usage="sysvInitScriptUninstall binary [ --help ]"
