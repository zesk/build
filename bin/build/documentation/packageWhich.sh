#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"binary - String. Required. The binary to look for"$'\n'"packageName ... - String. Optional. The package name to install if the binary is not found in the \`\$PATH\`. If not supplied uses the same name as the binary."$'\n'""
base="package.sh"
description="Installs an apt package if a binary does not exist in the which path."$'\n'"The assumption here is that \`packageInstallPackage\` will install the desired \`binary\`."$'\n'""$'\n'"Confirms that \`binary\` is installed after installation succeeds."$'\n'""$'\n'""
environment="Technically this will install the binary and any related files as a package."$'\n'""
example="    packageWhich shellcheck shellcheck"$'\n'"    packageWhich mariadb mariadb-client"$'\n'""
file="bin/build/tools/package.sh"
fn="packageWhich"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Install tools using \`apt-get\` if they are not found"$'\n'""
usage="packageWhich [ --manager packageManager ] binary [ packageName ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageWhich[0m [94m[ --manager packageManager ][0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m [94m[ packageName ... ][0m

    [94m--manager packageManager  [1;97mString. Optional. Package manager to use. (apk, apt, brew)[0m
    [31mbinary                    [1;97mString. Required. The binary to look for[0m
    [94mpackageName ...           [1;97mString. Optional. The package name to install if the binary is not found in the [38;2;0;255;0;48;2;0;0;0m$PATH[0m. If not supplied uses the same name as the binary.[0m

Installs an apt package if a binary does not exist in the which path.
The assumption here is that [38;2;0;255;0;48;2;0;0;0mpackageInstallPackage[0m will install the desired [38;2;0;255;0;48;2;0;0;0mbinary[0m.

Confirms that [38;2;0;255;0;48;2;0;0;0mbinary[0m is installed after installation succeeds.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Technically this will install the binary and any related files as a package.
- 

Example:
    packageWhich shellcheck shellcheck
    packageWhich mariadb mariadb-client
'
# shellcheck disable=SC2016
helpPlain='Usage: packageWhich [ --manager packageManager ] binary [ packageName ... ]

    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)
    binary                    String. Required. The binary to look for
    packageName ...           String. Optional. The package name to install if the binary is not found in the $PATH. If not supplied uses the same name as the binary.

Installs an apt package if a binary does not exist in the which path.
The assumption here is that packageInstallPackage will install the desired binary.

Confirms that binary is installed after installation succeeds.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Technically this will install the binary and any related files as a package.
- 

Example:
    packageWhich shellcheck shellcheck
    packageWhich mariadb mariadb-client
'
