#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install tofu binary"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="tofuInstall"
fnMarker="tofuinstall"
foundNames=([0]="argument" [1]="see")
line="59"
rawComment="Install tofu binary"$'\n'"Argument: package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuUninstall packageInstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="tofuUninstall packageInstall"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="59"
summary="Install tofu binary"
summaryComputed="true"
usage="tofuInstall [ package ] [ --help ]"
