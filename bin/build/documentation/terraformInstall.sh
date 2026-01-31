#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="package ... - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'""
base="terraform.sh"
description="Install terraform binary"$'\n'""
file="bin/build/tools/terraform.sh"
rawComment="Install terraform binary"$'\n'"Argument: package ... - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="3c2857a89f3ea63f9954ca35089a6ed0053d74da"
summary="Install terraform binary"
summaryComputed="true"
usage="terraformInstall [ package ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mterraformInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage ...  '$'\e''[[(value)]mString. Optional. Additional packages to install using '$'\e''[[(code)]mpackageInstall'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Install terraform binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: terraformInstall [ package ... ]'$'\n'''$'\n''    package ...  String. Optional. Additional packages to install using packageInstall'$'\n'''$'\n''Install terraform binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
