#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="terraform.sh"
description="Remove terraform binary"$'\n'"Argument: package ... - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'""
file="bin/build/tools/terraform.sh"
foundNames=()
rawComment="Remove terraform binary"$'\n'"Argument: package ... - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="3c2857a89f3ea63f9954ca35089a6ed0053d74da"
summary="Remove terraform binary"
usage="terraformUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mterraformUninstall'$'\e''[0m'$'\n'''$'\n''Remove terraform binary'$'\n''Argument: package ... - String. Optional. Additional packages to uninstall using '$'\e''[[(code)]mpackageUninstall'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: terraformUninstall'$'\n'''$'\n''Remove terraform binary'$'\n''Argument: package ... - String. Optional. Additional packages to uninstall using packageUninstall'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.695
