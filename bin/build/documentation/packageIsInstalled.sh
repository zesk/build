#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - String. Required. One or more packages to check if they are installed"$'\n'""
base="package.sh"
description="Is a package installed?"$'\n'"Return Code: 1 - If any packages are not installed"$'\n'"Return Code: 0 - All packages are installed"$'\n'""
file="bin/build/tools/package.sh"
fn="packageIsInstalled"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Is a package installed?"
usage="packageIsInstalled package"
