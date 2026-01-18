#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"binary - String. Required. The binary to look for"$'\n'"packageName ... - String. Optional. The package name to install if the binary is not found in the \`\$PATH\`. If not supplied uses the same name as the binary."$'\n'""
base="package.sh"
description="Installs an apt package if a binary does not exist in the which path."$'\n'"The assumption here is that \`packageInstallPackage\` will install the desired \`binary\`."$'\n'""$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'""$'\n'""
environment="Technically this will install the binary and any related files as a package."$'\n'""
example="    packageWhich shellcheck shellcheck"$'\n'"    packageWhich mariadb mariadb-client"$'\n'""
file="bin/build/tools/package.sh"
fn="packageWhich"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Install tools using \`apt-get\` if they are not found"$'\n'""
usage="packageWhich [ --manager packageManager ] binary [ packageName ... ]"
