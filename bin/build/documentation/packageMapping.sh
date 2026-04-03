#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="packageName - A simple package name which will be expanded to specific platform or package-manager specific package names"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
description="No documentation for \`packageMapping\`."$'\n'""
file="bin/build/tools/package.sh"
fn="packageMapping"
foundNames=([0]="argument")
rawComment="Argument: packageName - A simple package name which will be expanded to specific platform or package-manager specific package names"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="06e25fa25995eb0e6d2d2931f09e11b0a6055bee"
summary="undocumented"
usage="packageMapping [ packageName ] [ --manager packageManager ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageMapping'$'\e''[0m '$'\e''[[(blue)]m[ packageName ]'$'\e''[0m '$'\e''[[(blue)]m[ --manager packageManager ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackageName               '$'\e''[[(value)]mA simple package name which will be expanded to specific platform or package-manager specific package names'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--manager packageManager  '$'\e''[[(value)]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]mpackageMapping'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageMapping [ packageName ] [ --manager packageManager ]'$'\n'''$'\n''    packageName               A simple package name which will be expanded to specific platform or package-manager specific package names'$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n'''$'\n''No documentation for packageMapping.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
