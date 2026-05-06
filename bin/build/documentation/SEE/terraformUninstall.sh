#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package ... - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'""
base="terraform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove terraform binary"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/terraform.sh"
fn="terraformUninstall"
fnMarker="terraformuninstall"
foundNames=([0]="argument")
line="66"
rawComment="Remove terraform binary"$'\n'"Argument: package ... - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="a4f8e3a7c7ca38d2b31358ac40b4ce3eafce0d6f"
sourceLine="66"
summary="Remove terraform binary"
summaryComputed="true"
usage="terraformUninstall [ package ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mterraformUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage ...  '$'\e''[[(value)]mString. Optional. Additional packages to uninstall using '$'\e''[[(code)]mpackageUninstall'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Remove terraform binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: terraformUninstall [ package ... ]'$'\n'''$'\n''    package ...  String. Optional. Additional packages to uninstall using packageUninstall'$'\n'''$'\n''Remove terraform binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/install.md"
