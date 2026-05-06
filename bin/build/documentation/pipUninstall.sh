#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"pipPackage [ ... ] - String. Required. Pip package name to uninstall."$'\n'""
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Utility to uninstall python dependencies via pip"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/python.sh"
fn="pipUninstall"
fnMarker="pipuninstall"
foundNames=([0]="argument")
line="137"
rawComment="Utility to uninstall python dependencies via pip"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: pipPackage [ ... ] - String. Required. Pip package name to uninstall."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c5956e3d32ee75e52908b4d36d8cfde5928066e8"
sourceLine="137"
summary="Utility to uninstall python dependencies via pip"
summaryComputed="true"
usage="pipUninstall [ --help ] [ --handler handler ] pipPackage [ ... ]"
