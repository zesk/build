#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"binary - String. Required. The binary to look for."$'\n'"packageInstallPackage - String. Required. The package name to uninstall if the binary is found in the \`\$PATH\`."$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Installs an apt package if a binary does not exist in the \`which\` path (e.g. \`\$PATH\`)"$'\n'"The assumption here is that \`packageUninstall\` will install the desired \`binary\`."$'\n'""$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'""$'\n'""
descriptionLineCount="5"
environment="Technically this will uninstall the binary and any related files as a package."$'\n'""
example="    packageWhichUninstall mariadb mariadb-client"$'\n'""
file="bin/build/tools/package.sh"
fn="packageWhichUninstall"
fnMarker="packagewhichuninstall"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="environment")
line="306"
rawComment="Installs an apt package if a binary does not exist in the \`which\` path (e.g. \`\$PATH\`)"$'\n'"The assumption here is that \`packageUninstall\` will install the desired \`binary\`."$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'"Summary: Install tools using \`apt-get\` if they are not found"$'\n'"Example:     packageWhichUninstall mariadb mariadb-client"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"Argument: binary - String. Required. The binary to look for."$'\n'"Argument: packageInstallPackage - String. Required. The package name to uninstall if the binary is found in the \`\$PATH\`."$'\n'"Environment: Technically this will uninstall the binary and any related files as a package."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="306"
summary="Install tools using \`apt-get\` if they are not found"
summaryComputed=""
usage="packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage"
