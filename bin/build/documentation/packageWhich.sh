#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\nbinary - String. Required. The binary to look for\npackageName ... - String. Optional. The package name to install if the binary is not found in the `$PATH`. If not supplied uses the same name as the binary.\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Installs an apt package if a binary does not exist in the which path.\nThe assumption here is that `packageInstallPackage` will install the desired `binary`.\n\nConfirms that `binary` is installed after installation succeeds.\n\n'
descriptionLineCount="5"
environment=$'Technically this will install the binary and any related files as a package.\n'
example=$'    packageWhich mariadb mariadb-client\n'
file="bin/build/tools/package.sh"
fn="packageWhich"
fnMarker="packagewhich"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="environment")
line="233"
rawComment=$'Installs an apt package if a binary does not exist in the which path.\nThe assumption here is that `packageInstallPackage` will install the desired `binary`.\nConfirms that `binary` is installed after installation succeeds.\nSummary: Install tools using `apt-get` if they are not found\nExample:     packageWhich mariadb mariadb-client\nArgument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\nArgument: binary - String. Required. The binary to look for\nArgument: packageName ... - String. Optional. The package name to install if the binary is not found in the `$PATH`. If not supplied uses the same name as the binary.\nEnvironment: Technically this will install the binary and any related files as a package.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="233"
summary="Install tools using \`apt-get\` if they are not found"
summaryComputed=""
usage="packageWhich [ --manager packageManager ] binary [ packageName ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageWhich'$'\e''[0m '$'\e''[[(blue)]m[ --manager packageManager ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ packageName ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--manager packageManager  '$'\e''[[(value)]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary                    '$'\e''[[(value)]mString. Required. The binary to look for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpackageName ...           '$'\e''[[(value)]mString. Optional. The package name to install if the binary is not found in the '$'\e''[[(code)]m$PATH'$'\e''[[(reset)]m. If not supplied uses the same name as the binary.'$'\e''[[(reset)]m'$'\n'''$'\n''Installs an apt package if a binary does not exist in the which path.'$'\n''The assumption here is that '$'\e''[[(code)]mpackageInstallPackage'$'\e''[[(reset)]m will install the desired '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\n'''$'\n''Confirms that '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m is installed after installation succeeds.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Technically this will install the binary and any related files as a package.'$'\n'''$'\n''Example:'$'\n''    packageWhich mariadb mariadb-client'
# shellcheck disable=SC2016
helpPlain='Usage: packageWhich [ --manager packageManager ] binary [ packageName ... ]'$'\n'''$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n''    binary                    String. Required. The binary to look for'$'\n''    packageName ...           String. Optional. The package name to install if the binary is not found in the $PATH. If not supplied uses the same name as the binary.'$'\n'''$'\n''Installs an apt package if a binary does not exist in the which path.'$'\n''The assumption here is that packageInstallPackage will install the desired binary.'$'\n'''$'\n''Confirms that binary is installed after installation succeeds.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Technically this will install the binary and any related files as a package.'$'\n'''$'\n''Example:'$'\n''    packageWhich mariadb mariadb-client'
documentationPath="documentation/source/tools/package.md"
