#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="packageName - A simple package name which will be expanded to specific platform or package-manager specific package names"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="No documentation for \`packageMapping\`."$'\n'""
descriptionLineCount=""
file="bin/build/tools/package.sh"
fn="packageMapping"
fnMarker="packagemapping"
foundNames=([0]="argument")
line="830"
rawComment="Argument: packageName - A simple package name which will be expanded to specific platform or package-manager specific package names"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="830"
summary="undocumented"
summaryComputed=""
usage="packageMapping [ packageName ] [ --manager packageManager ]"
