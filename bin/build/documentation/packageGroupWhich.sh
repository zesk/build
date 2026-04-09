#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="binary - String. Required. Binary which will exist in PATH after \`group\` is installed if it does not exist."$'\n'"group - String. Required. Package group."$'\n'""
base="package.sh"
description="Install a package group to have a binary installed"$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""
file="bin/build/tools/package.sh"
fn="packageGroupWhich"
foundNames=([0]="argument")
line="687"
lowerFn="packagegroupwhich"
rawComment="Install a package group to have a binary installed"$'\n'"Argument: binary - String. Required. Binary which will exist in PATH after \`group\` is installed if it does not exist."$'\n'"Argument: group - String. Required. Package group."$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="06e25fa25995eb0e6d2d2931f09e11b0a6055bee"
sourceLine="687"
summary="Install a package group to have a binary installed"
summaryComputed="true"
usage="packageGroupWhich binary group"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageGroupWhich'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mgroup'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mString. Required. Binary which will exist in PATH after '$'\e''[[(code)]mgroup'$'\e''[[(reset)]m is installed if it does not exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mgroup   '$'\e''[[(value)]mString. Required. Package group.'$'\e''[[(reset)]m'$'\n'''$'\n''Install a package group to have a binary installed'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupWhich binary group'$'\n'''$'\n''    binary  String. Required. Binary which will exist in PATH after group is installed if it does not exist.'$'\n''    group   String. Required. Package group.'$'\n'''$'\n''Install a package group to have a binary installed'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/package.md"
