#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'package - String. Optional. Additional packages to install using `packageInstall`\n--help - Flag. Optional. Display this help.\n'
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install tofu binary\n\n'
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="tofuInstall"
fnMarker="tofuinstall"
foundNames=([0]="argument" [1]="see")
line="59"
rawComment=$'Install tofu binary\nArgument: package - String. Optional. Additional packages to install using `packageInstall`\nArgument: --help - Flag. Optional. Display this help.\nSee: tofuUninstall packageInstall\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'tofuUninstall packageInstall\n'
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="59"
summary="Install tofu binary"
summaryComputed="true"
usage="tofuInstall [ package ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtofuInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mString. Optional. Additional packages to install using '$'\e''[[(code)]mpackageInstall'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install tofu binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: tofuInstall [ package ] [ --help ]'$'\n'''$'\n''    package  String. Optional. Additional packages to install using packageInstall'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Install tofu binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/tofu.md"
