#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Prints the build home directory (usually same as the application root)"$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_HOME"$'\n'""
file="bin/build/tools/build.sh"
fn="buildHome"
fnMarker="buildhome"
foundNames=([0]="environment" [1]="argument")
line="152"
rawComment="Environment: BUILD_HOME"$'\n'"Prints the build home directory (usually same as the application root)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="152"
summary="Prints the build home directory (usually same as the application"
summaryComputed="true"
usage="buildHome [ --help ]"
