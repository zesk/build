#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="package - String. Required. One or more packages to check if they are installed"$'\n'""
base="package.sh"
description="Is a package installed?"$'\n'""
file="bin/build/tools/package.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is a package installed?"$'\n'"Argument: package - String. Required. One or more packages to check if they are installed"$'\n'"Return Code: 1 - If any packages are not installed"$'\n'"Return Code: 0 - All packages are installed"$'\n'""$'\n'""
return_code="1 - If any packages are not installed"$'\n'"0 - All packages are installed"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="42f79b3d34a0383d43d5dccba57a982493535358"
summary="Is a package installed?"
usage="packageIsInstalled package"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageIsInstalled'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpackage'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mpackage  '$'\e''[[(value)]mString. Required. One or more packages to check if they are installed'$'\e''[[(reset)]m'$'\n'''$'\n''Is a package installed?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any packages are not installed'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All packages are installed'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mpackageIsInstalled [[(bold)]mpackage'$'\n'''$'\n''    [[(red)]mpackage  [[(value)]mString. Required. One or more packages to check if they are installed'$'\n'''$'\n''Is a package installed?'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m1 - If any packages are not installed'$'\n''- [[(code)]m0 - All packages are installed'$'\n'''
# elapsed 2.184
