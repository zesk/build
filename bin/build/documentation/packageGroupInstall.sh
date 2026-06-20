#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'group - String. Required. Currently allowed: "python"\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install a package group\nAny unrecognized groups are installed using the name as-is.\n\n'
descriptionLineCount="3"
file="bin/build/tools/package.sh"
fn="packageGroupInstall"
fnMarker="packagegroupinstall"
foundNames=([0]="argument")
line="734"
original="packageGroupInstall"
rawComment=$'Install a package group\nArgument: group - String. Required. Currently allowed: "python"\nAny unrecognized groups are installed using the name as-is.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="734"
summary="Install a package group"
summaryComputed="true"
usage="packageGroupInstall group"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageGroupInstall'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mgroup'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mgroup  '$'\e''[[(value)]mString. Required. Currently allowed: "python"'$'\e''[[(reset)]m'$'\n'''$'\n''Install a package group'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupInstall group'$'\n'''$'\n''    group  String. Required. Currently allowed: "python"'$'\n'''$'\n''Install a package group'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
