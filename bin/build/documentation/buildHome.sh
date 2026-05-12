#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Prints the build home directory (usually same as the application root)\n\n'
descriptionLineCount="2"
environment=$'BUILD_HOME\n'
file="bin/build/tools/build.sh"
fn="buildHome"
fnMarker="buildhome"
foundNames=([0]="environment" [1]="argument")
line="152"
rawComment=$'Environment: BUILD_HOME\nPrints the build home directory (usually same as the application root)\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="152"
summary="Prints the build home directory (usually same as the application"
summaryComputed="true"
usage="buildHome [ --help ]"
