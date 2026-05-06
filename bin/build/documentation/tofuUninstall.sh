#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Uninstall tofu binary and apt sources keys"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="tofuUninstall"
fnMarker="tofuuninstall"
foundNames=([0]="argument" [1]="see")
line="80"
rawComment="Uninstall tofu binary and apt sources keys"$'\n'"Argument: package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuInstall packageUninstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="tofuInstall packageUninstall"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="80"
summary="Uninstall tofu binary and apt sources keys"
summaryComputed="true"
usage="tofuUninstall [ package ] [ --help ]"
