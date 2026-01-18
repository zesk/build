#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sysvinit.sh"
argument="binary - String. Required. Binary to install at startup."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="sysvinit.sh"
description="Install a script to run upon initialization."$'\n'""
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptInstall"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sysvinit.sh"
sourceModified="1768721470"
summary="Install a script to run upon initialization."
usage="sysvInitScriptInstall binary [ --help ]"
