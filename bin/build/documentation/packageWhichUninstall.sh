#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"binary - String. Required. The binary to look for."$'\n'"packageInstallPackage - String. Required. The package name to uninstall if the binary is found in the \`\$PATH\`."$'\n'""
base="package.sh"
description="Installs an apt package if a binary does not exist in the \`which\` path (e.g. \`\$PATH\`)"$'\n'"The assumption here is that \`packageUninstall\` will install the desired \`binary\`."$'\n'""$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'""$'\n'""$'\n'""
environment="Technically this will uninstall the binary and any related files as a package."$'\n'""
example="    packageWhichUninstall shellcheck shellcheck"$'\n'"    packageWhichUninstall mariadb mariadb-client"$'\n'""
file="bin/build/tools/package.sh"
fn="packageWhichUninstall"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Install tools using \`apt-get\` if they are not found"$'\n'""
usage="packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage"
