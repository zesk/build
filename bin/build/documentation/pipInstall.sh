#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"pipPackage [ ... ] - String. Required. Pip package name to install."$'\n'""
base="python.sh"
description="Utility to install python dependencies via pip"$'\n'"Installs python if it hasn't been using \`pythonInstall\`."$'\n'""
file="bin/build/tools/python.sh"
fn="pipInstall"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/python.sh"
sourceModified="1768695708"
summary="Utility to install python dependencies via pip"
usage="pipInstall [ --help ] [ --handler handler ] pipPackage [ ... ]"
