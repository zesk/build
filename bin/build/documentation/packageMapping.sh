#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'packageName - A simple package name which will be expanded to specific platform or package-manager specific package names\n--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'No documentation for `packageMapping`.\n'
descriptionLineCount=""
file="bin/build/tools/package.sh"
fn="packageMapping"
fnMarker="packagemapping"
foundNames=([0]="argument")
line="829"
original="packageMapping"
rawComment=$'Argument: packageName - A simple package name which will be expanded to specific platform or package-manager specific package names\nArgument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="829"
summary="undocumented"
summaryComputed=""
usage="packageMapping [ packageName ] [ --manager packageManager ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageMapping'$'\e''[0m '$'\e''[[(blue)]m[ packageName ]'$'\e''[0m '$'\e''[[(blue)]m[ --manager packageManager ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackageName               '$'\e''[[(value)]mA simple package name which will be expanded to specific platform or package-manager specific package names'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--manager packageManager  '$'\e''[[(value)]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]mpackageMapping'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageMapping [ packageName ] [ --manager packageManager ]'$'\n'''$'\n''    packageName               A simple package name which will be expanded to specific platform or package-manager specific package names'$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n'''$'\n''No documentation for packageMapping.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
