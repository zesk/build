#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"binary - String. Required. The binary to look for"$'\n'"packageName ... - String. Optional. The package name to install if the binary is not found in the \`\$PATH\`. If not supplied uses the same name as the binary."$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Installs an apt package if a binary does not exist in the which path."$'\n'"The assumption here is that \`packageInstallPackage\` will install the desired \`binary\`."$'\n'""$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'""$'\n'""
descriptionLineCount="5"
environment="Technically this will install the binary and any related files as a package."$'\n'""
example="    packageWhich mariadb mariadb-client"$'\n'""
file="bin/build/tools/package.sh"
fn="packageWhich"
fnMarker="packagewhich"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="environment")
line="233"
rawComment="Installs an apt package if a binary does not exist in the which path."$'\n'"The assumption here is that \`packageInstallPackage\` will install the desired \`binary\`."$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'"Summary: Install tools using \`apt-get\` if they are not found"$'\n'"Example:     packageWhich mariadb mariadb-client"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"Argument: binary - String. Required. The binary to look for"$'\n'"Argument: packageName ... - String. Optional. The package name to install if the binary is not found in the \`\$PATH\`. If not supplied uses the same name as the binary."$'\n'"Environment: Technically this will install the binary and any related files as a package."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="233"
summary="Install tools using \`apt-get\` if they are not found"
summaryComputed=""
usage="packageWhich [ --manager packageManager ] binary [ packageName ... ]"
