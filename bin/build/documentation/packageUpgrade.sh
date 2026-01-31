#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="Upgrade packages lists and sources"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Display progress to the terminal."$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"Argument: --force - Flag. Optional. Force even if it was updated recently."$'\n'""
file="bin/build/tools/package.sh"
foundNames=()
rawComment="Upgrade packages lists and sources"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Display progress to the terminal."$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"Argument: --force - Flag. Optional. Force even if it was updated recently."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="42f79b3d34a0383d43d5dccba57a982493535358"
summary="Upgrade packages lists and sources"
usage="packageUpgrade"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageUpgrade'$'\e''[0m'$'\n'''$'\n''Upgrade packages lists and sources'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --verbose - Flag. Optional. Display progress to the terminal.'$'\n''Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)'$'\n''Argument: --force - Flag. Optional. Force even if it was updated recently.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageUpgrade'$'\n'''$'\n''Upgrade packages lists and sources'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --verbose - Flag. Optional. Display progress to the terminal.'$'\n''Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)'$'\n''Argument: --force - Flag. Optional. Force even if it was updated recently.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.49
