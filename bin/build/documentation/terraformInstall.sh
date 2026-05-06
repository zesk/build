#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package ... - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'""
base="terraform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install terraform binary"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/terraform.sh"
fn="terraformInstall"
fnMarker="terraforminstall"
foundNames=([0]="argument")
line="46"
rawComment="Install terraform binary"$'\n'"Argument: package ... - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="a4f8e3a7c7ca38d2b31358ac40b4ce3eafce0d6f"
sourceLine="46"
summary="Install terraform binary"
summaryComputed="true"
usage="terraformInstall [ package ... ]"
