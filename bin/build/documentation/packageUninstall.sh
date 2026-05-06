#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - String. Required. One or more packages to uninstall"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Removes packages using the current package manager."$'\n'""$'\n'""
descriptionLineCount="2"
example="    packageUninstall shellcheck"$'\n'""
file="bin/build/tools/package.sh"
fn="packageUninstall"
fnMarker="packageuninstall"
foundNames=([0]="example" [1]="summary" [2]="argument")
line="524"
rawComment="Removes packages using the current package manager."$'\n'"Example:     {fn} shellcheck"$'\n'"Summary: Removes packages using package manager"$'\n'"Argument: package - String. Required. One or more packages to uninstall"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="524"
summary="Removes packages using package manager"
summaryComputed=""
usage="packageUninstall package [ --manager packageManager ]"
