#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\nbinary - String. Required. The binary to look for.\npackageInstallPackage - String. Required. The package name to uninstall if the binary is found in the `$PATH`.\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)\nThe assumption here is that `packageUninstall` will install the desired `binary`.\n\nConfirms that `binary` is installed after installation succeeds.\n\n'
descriptionLineCount="5"
environment=$'Technically this will uninstall the binary and any related files as a package.\n'
example=$'    packageWhichUninstall mariadb mariadb-client\n'
file="bin/build/tools/package.sh"
fn="packageWhichUninstall"
fnMarker="packagewhichuninstall"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="environment")
line="306"
rawComment=$'Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)\nThe assumption here is that `packageUninstall` will install the desired `binary`.\nConfirms that `binary` is installed after installation succeeds.\nSummary: Install tools using `apt-get` if they are not found\nExample:     packageWhichUninstall mariadb mariadb-client\nArgument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\nArgument: binary - String. Required. The binary to look for.\nArgument: packageInstallPackage - String. Required. The package name to uninstall if the binary is found in the `$PATH`.\nEnvironment: Technically this will uninstall the binary and any related files as a package.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="6c84223fe5bc14c2b9baec08ee22b36edea72ad6"
sourceLine="306"
summary="Install tools using \`apt-get\` if they are not found"
summaryComputed=""
usage="packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageWhichUninstall'$'\e''[0m '$'\e''[[(blue)]m[ --manager packageManager ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpackageInstallPackage'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--manager packageManager  '$'\e''[[(value)]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary                    '$'\e''[[(value)]mString. Required. The binary to look for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpackageInstallPackage     '$'\e''[[(value)]mString. Required. The package name to uninstall if the binary is found in the '$'\e''[[(code)]m$PATH'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Installs an apt package if a binary does not exist in the '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m path (e.g. '$'\e''[[(code)]m$PATH'$'\e''[[(reset)]m)'$'\n''The assumption here is that '$'\e''[[(code)]mpackageUninstall'$'\e''[[(reset)]m will install the desired '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\n'''$'\n''Confirms that '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m is installed after installation succeeds.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Technically this will uninstall the binary and any related files as a package.'$'\n'''$'\n''Example:'$'\n''    packageWhichUninstall mariadb mariadb-client'
# shellcheck disable=SC2016
helpPlain='Usage: packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage'$'\n'''$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n''    binary                    String. Required. The binary to look for.'$'\n''    packageInstallPackage     String. Required. The package name to uninstall if the binary is found in the $PATH.'$'\n'''$'\n''Installs an apt package if a binary does not exist in the which path (e.g. $PATH)'$'\n''The assumption here is that packageUninstall will install the desired binary.'$'\n'''$'\n''Confirms that binary is installed after installation succeeds.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Technically this will uninstall the binary and any related files as a package.'$'\n'''$'\n''Example:'$'\n''    packageWhichUninstall mariadb mariadb-client'
documentationPath="documentation/source/tools/package.md"
