#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="aws Command-Line install"$'\n'""$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/aws.sh"
fn="awsInstall"
fnMarker="awsinstall"
foundNames=([0]="requires")
line="30"
rawComment="aws Command-Line install"$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'"Requires: packageInstall urlFetch"$'\n'""$'\n'""
requires="packageInstall urlFetch"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="30"
summary="aws Command-Line install"
summaryComputed="true"
usage="awsInstall"
