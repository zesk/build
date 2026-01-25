#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - String. Required. One or more packages to check if they are installed"$'\n'""
base="package.sh"
description="Is a package installed?"$'\n'""
exitCode="0"
file="bin/build/tools/package.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is a package installed?"$'\n'"Argument: package - String. Required. One or more packages to check if they are installed"$'\n'"Return Code: 1 - If any packages are not installed"$'\n'"Return Code: 0 - All packages are installed"$'\n'""$'\n'""
return_code="1 - If any packages are not installed"$'\n'"0 - All packages are installed"$'\n'""
sourceModified="1769184734"
summary="Is a package installed?"
usage="packageIsInstalled package"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpackageIsInstalled'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mpackage'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mpackage  '$'\e''[[value]mString. Required. One or more packages to check if they are installed'$'\e''[[reset]m'$'\n'''$'\n''Is a package installed?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - If any packages are not installed'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - All packages are installed'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageIsInstalled package'$'\n'''$'\n''    package  String. Required. One or more packages to check if they are installed'$'\n'''$'\n''Is a package installed?'$'\n'''$'\n''Return codes:'$'\n''- 1 - If any packages are not installed'$'\n''- 0 - All packages are installed'$'\n'''
