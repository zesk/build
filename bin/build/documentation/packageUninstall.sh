#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - String. Required. One or more packages to uninstall"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
description="Removes packages using the current package manager."$'\n'""$'\n'""
example="    packageUninstall shellcheck"$'\n'""
file="bin/build/tools/package.sh"
fn="packageUninstall"
foundNames=([0]="example" [1]="summary" [2]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768695708"
summary="Removes packages using package manager"$'\n'""
usage="packageUninstall package [ --manager packageManager ]"
