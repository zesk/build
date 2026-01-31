#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="Uninstall a package group"$'\n'"Argument: group - String. Required. Currently allowed: \"python\""$'\n'"Any unrecognized groups are uninstalled using the name as-is."$'\n'""
file="bin/build/tools/package.sh"
foundNames=()
rawComment="Uninstall a package group"$'\n'"Argument: group - String. Required. Currently allowed: \"python\""$'\n'"Any unrecognized groups are uninstalled using the name as-is."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="42f79b3d34a0383d43d5dccba57a982493535358"
summary="Uninstall a package group"
usage="packageGroupUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageGroupUninstall'$'\e''[0m'$'\n'''$'\n''Uninstall a package group'$'\n''Argument: group - String. Required. Currently allowed: "python"'$'\n''Any unrecognized groups are uninstalled using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupUninstall'$'\n'''$'\n''Uninstall a package group'$'\n''Argument: group - String. Required. Currently allowed: "python"'$'\n''Any unrecognized groups are uninstalled using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.522
