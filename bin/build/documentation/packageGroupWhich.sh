#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'binary - String. Required. Binary which will exist in PATH after `group` is installed if it does not exist.\ngroup - String. Required. Package group.\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install a package group to have a binary installed\nAny unrecognized groups are installed using the name as-is.\n\n'
descriptionLineCount="3"
file="bin/build/tools/package.sh"
fn="packageGroupWhich"
fnMarker="packagegroupwhich"
foundNames=([0]="argument")
line="686"
original="packageGroupWhich"
rawComment=$'Install a package group to have a binary installed\nArgument: binary - String. Required. Binary which will exist in PATH after `group` is installed if it does not exist.\nArgument: group - String. Required. Package group.\nAny unrecognized groups are installed using the name as-is.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="686"
summary="Install a package group to have a binary installed"
summaryComputed="true"
usage="packageGroupWhich binary group"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageGroupWhich'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mgroup'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mString. Required. Binary which will exist in PATH after '$'\e''[[(code)]mgroup'$'\e''[[(reset)]m is installed if it does not exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mgroup   '$'\e''[[(value)]mString. Required. Package group.'$'\e''[[(reset)]m'$'\n'''$'\n''Install a package group to have a binary installed'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupWhich binary group'$'\n'''$'\n''    binary  String. Required. Binary which will exist in PATH after group is installed if it does not exist.'$'\n''    group   String. Required. Package group.'$'\n'''$'\n''Install a package group to have a binary installed'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
