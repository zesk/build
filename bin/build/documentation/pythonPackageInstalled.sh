#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="pipPackage ... - String. Required. Package name(s) to check."$'\n'"--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"--any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'""
base="python.sh"
description="Is a package installed for python?"$'\n'"Return Code: 0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"Return Code: 1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""
file="bin/build/tools/python.sh"
fn="pythonPackageInstalled"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/python.sh"
sourceModified="1768695708"
summary="Is a package installed for python?"
usage="pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]"
