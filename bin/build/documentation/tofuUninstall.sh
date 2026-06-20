#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'package - String. Optional. Additional packages to uninstall using `packageUninstall`\n--help - Flag. Optional. Display this help.\n'
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Uninstall tofu binary and apt sources keys\n\n'
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="tofuUninstall"
fnMarker="tofuuninstall"
foundNames=([0]="argument" [1]="see")
line="80"
original="tofuUninstall"
rawComment=$'Uninstall tofu binary and apt sources keys\nArgument: package - String. Optional. Additional packages to uninstall using `packageUninstall`\nArgument: --help - Flag. Optional. Display this help.\nSee: tofuInstall packageUninstall\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'tofuInstall packageUninstall\n'
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="80"
summary="Uninstall tofu binary and apt sources keys"
summaryComputed="true"
usage="tofuUninstall [ package ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtofuUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mString. Optional. Additional packages to uninstall using '$'\e''[[(code)]mpackageUninstall'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstall tofu binary and apt sources keys'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: tofuUninstall [ package ] [ --help ]'$'\n'''$'\n''    package  String. Optional. Additional packages to uninstall using packageUninstall'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Uninstall tofu binary and apt sources keys'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/tofu.md"
