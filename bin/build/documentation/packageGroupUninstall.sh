#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="group - String. Required. Currently allowed: \"python\""$'\n'""
base="package.sh"
description="Uninstall a package group"$'\n'"Any unrecognized groups are uninstalled using the name as-is."$'\n'""
file="bin/build/tools/package.sh"
fn="packageGroupUninstall"
foundNames=([0]="argument")
line="784"
lowerFn="packagegroupuninstall"
rawComment="Uninstall a package group"$'\n'"Argument: group - String. Required. Currently allowed: \"python\""$'\n'"Any unrecognized groups are uninstalled using the name as-is."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="784"
summary="Uninstall a package group"
summaryComputed="true"
usage="packageGroupUninstall group"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageGroupUninstall'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mgroup'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mgroup  '$'\e''[[(value)]mString. Required. Currently allowed: "python"'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstall a package group'$'\n''Any unrecognized groups are uninstalled using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupUninstall group'$'\n'''$'\n''    group  String. Required. Currently allowed: "python"'$'\n'''$'\n''Uninstall a package group'$'\n''Any unrecognized groups are uninstalled using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/package.md"
