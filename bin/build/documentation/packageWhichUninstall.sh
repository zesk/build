#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"binary - String. Required. The binary to look for."$'\n'"packageInstallPackage - String. Required. The package name to uninstall if the binary is found in the \`\$PATH\`."$'\n'""
base="package.sh"
description="Installs an apt package if a binary does not exist in the \`which\` path (e.g. \`\$PATH\`)"$'\n'"The assumption here is that \`packageUninstall\` will install the desired \`binary\`."$'\n'""$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'""$'\n'""$'\n'""
environment="Technically this will uninstall the binary and any related files as a package."$'\n'""
example="    packageWhichUninstall shellcheck shellcheck"$'\n'"    packageWhichUninstall mariadb mariadb-client"$'\n'""
file="bin/build/tools/package.sh"
fn="packageWhichUninstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Install tools using \`apt-get\` if they are not found"$'\n'""
usage="packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageWhichUninstall[0m [94m[ --manager packageManager ][0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mpackageInstallPackage[0m[0m

    [94m--manager packageManager  [1;97mString. Optional. Package manager to use. (apk, apt, brew)[0m
    [31mbinary                    [1;97mString. Required. The binary to look for.[0m
    [31mpackageInstallPackage     [1;97mString. Required. The package name to uninstall if the binary is found in the [38;2;0;255;0;48;2;0;0;0m$PATH[0m.[0m

Installs an apt package if a binary does not exist in the [38;2;0;255;0;48;2;0;0;0mwhich[0m path (e.g. [38;2;0;255;0;48;2;0;0;0m$PATH[0m)
The assumption here is that [38;2;0;255;0;48;2;0;0;0mpackageUninstall[0m will install the desired [38;2;0;255;0;48;2;0;0;0mbinary[0m.

Confirms that [38;2;0;255;0;48;2;0;0;0mbinary[0m is installed after installation succeeds.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Technically this will uninstall the binary and any related files as a package.
- 

Example:
    packageWhichUninstall shellcheck shellcheck
    packageWhichUninstall mariadb mariadb-client
'
# shellcheck disable=SC2016
helpPlain='Usage: packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage

    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)
    binary                    String. Required. The binary to look for.
    packageInstallPackage     String. Required. The package name to uninstall if the binary is found in the $PATH.

Installs an apt package if a binary does not exist in the which path (e.g. $PATH)
The assumption here is that packageUninstall will install the desired binary.

Confirms that binary is installed after installation succeeds.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Technically this will uninstall the binary and any related files as a package.
- 

Example:
    packageWhichUninstall shellcheck shellcheck
    packageWhichUninstall mariadb mariadb-client
'
