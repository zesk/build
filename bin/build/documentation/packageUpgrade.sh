#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--verbose - Flag. Optional. Display progress to the terminal.\n--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\n--force - Flag. Optional. Force even if it was updated recently.\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Upgrade packages lists and sources\n\n'
descriptionLineCount="2"
file="bin/build/tools/package.sh"
fn="packageUpgrade"
fnMarker="packageupgrade"
foundNames=([0]="argument")
line="149"
rawComment=$'Upgrade packages lists and sources\nArgument: --help - Flag. Optional. Display this help.\nArgument: --verbose - Flag. Optional. Display progress to the terminal.\nArgument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)\nArgument: --force - Flag. Optional. Force even if it was updated recently.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="149"
summary="Upgrade packages lists and sources"
summaryComputed="true"
usage="packageUpgrade [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageUpgrade'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --manager packageManager ]'$'\e''[0m '$'\e''[[(blue)]m[ --force ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose                 '$'\e''[[(value)]mFlag. Optional. Display progress to the terminal.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--manager packageManager  '$'\e''[[(value)]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--force                   '$'\e''[[(value)]mFlag. Optional. Force even if it was updated recently.'$'\e''[[(reset)]m'$'\n'''$'\n''Upgrade packages lists and sources'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageUpgrade [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]'$'\n'''$'\n''    --help                    Flag. Optional. Display this help.'$'\n''    --verbose                 Flag. Optional. Display progress to the terminal.'$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n''    --force                   Flag. Optional. Force even if it was updated recently.'$'\n'''$'\n''Upgrade packages lists and sources'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
