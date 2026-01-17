#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - One or more packages to install"$'\n'"--verbose -  Flag. Optional.Display progress to the terminal."$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"--force -  Flag. Optional.Force even if it was updated recently."$'\n'"--show-log -  Flag. Optional.Show package manager logs."$'\n'""
artifact="\`packageInstall.log\` is left in the \`buildCacheDirectory\`"$'\n'""
base="package.sh"
description="Install packages using a package manager."$'\n'""$'\n'"Supported managers:"$'\n'"- apk"$'\n'"- apt-get"$'\n'"- brew"$'\n'""$'\n'"Return Code: 0 - If \`apk\` is not installed, returns 0."$'\n'"Return Code: 1 - If \`apk\` fails to install the packages"$'\n'""
example="    packageInstall shellcheck"$'\n'""
file="bin/build/tools/package.sh"
fn="packageInstall"
foundNames=([0]="example" [1]="summary" [2]="argument" [3]="artifact")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768683999"
summary="Install packages using a package manager"$'\n'""
usage="packageInstall [ package ] [ --verbose ] [ --manager packageManager ] [ --force ] [ --show-log ]"
