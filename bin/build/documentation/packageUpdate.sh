#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Display progress to the terminal."$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"--force - Flag. Optional. Force even if it was updated recently."$'\n'""
base="package.sh"
description="Update packages lists and sources"$'\n'""
exitCode="0"
file="bin/build/tools/package.sh"
foundNames=([0]="argument")
rawComment="Update packages lists and sources"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Display progress to the terminal."$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"Argument: --force - Flag. Optional. Force even if it was updated recently."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1769184734"
summary="Update packages lists and sources"
usage="packageUpdate [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpackageUpdate'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ --verbose ]'$'\e''[0m '$'\e''[[blue]m[ --manager packageManager ]'$'\e''[0m '$'\e''[[blue]m[ --force ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help                    '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--verbose                 '$'\e''[[value]mFlag. Optional. Display progress to the terminal.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--manager packageManager  '$'\e''[[value]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--force                   '$'\e''[[value]mFlag. Optional. Force even if it was updated recently.'$'\e''[[reset]m'$'\n'''$'\n''Update packages lists and sources'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageUpdate [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]'$'\n'''$'\n''    --help                    Flag. Optional. Display this help.'$'\n''    --verbose                 Flag. Optional. Display progress to the terminal.'$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n''    --force                   Flag. Optional. Force even if it was updated recently.'$'\n'''$'\n''Update packages lists and sources'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
