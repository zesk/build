#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List installed packages on this system using package manager\n\n'
descriptionLineCount="2"
file="bin/build/tools/package.sh"
fn="packageAvailableList"
fnMarker="packageavailablelist"
foundNames=()
line="647"
original="packageAvailableList"
rawComment=$'List installed packages on this system using package manager\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="647"
summary="List installed packages on this system using package manager"
summaryComputed="true"
usage="packageAvailableList"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageAvailableList'$'\e''[0m'$'\n'''$'\n''List installed packages on this system using package manager'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageAvailableList'$'\n'''$'\n''List installed packages on this system using package manager'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
