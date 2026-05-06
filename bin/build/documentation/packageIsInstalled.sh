#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - String. Required. One or more packages to check if they are installed"$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a package installed?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/package.sh"
fn="packageIsInstalled"
fnMarker="packageisinstalled"
foundNames=([0]="argument" [1]="return_code")
line="482"
rawComment="Is a package installed?"$'\n'"Argument: package - String. Required. One or more packages to check if they are installed"$'\n'"Return Code: 1 - If any packages are not installed"$'\n'"Return Code: 0 - All packages are installed"$'\n'""$'\n'""
return_code="1 - If any packages are not installed"$'\n'"0 - All packages are installed"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="482"
summary="Is a package installed?"
summaryComputed="true"
usage="packageIsInstalled package"
