#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate/theme.sh"
argument="--end - Flag. Optional. End themeless mode."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="theme.sh"
description="Converts decoration style to a mode where the theme can be applied later to text which is formatted."$'\n'"All decorate calls made after this call will output with special codes not to be displayed to the user."$'\n'""
environment="__BUILD_DECORATE"$'\n'""
exitCode="0"
file="bin/build/tools/decorate/theme.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Converts decoration style to a mode where the theme can be applied later to text which is formatted."$'\n'"All decorate calls made after this call will output with special codes not to be displayed to the user."$'\n'"Argument: --end - Flag. Optional. End themeless mode."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: __BUILD_DECORATE"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/theme.sh"
sourceModified="1769205723"
summary="Converts decoration style to a mode where the theme can"
usage="decorateThemelessMode [ --end ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdecorateThemelessMode'$'\e''[0m '$'\e''[[blue]m[ --end ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--end   '$'\e''[[value]mFlag. Optional. End themeless mode.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Converts decoration style to a mode where the theme can be applied later to text which is formatted.'$'\n''All decorate calls made after this call will output with special codes not to be displayed to the user.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_DECORATE'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorateThemelessMode [ --end ] [ --help ]'$'\n'''$'\n''    --end   Flag. Optional. End themeless mode.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Converts decoration style to a mode where the theme can be applied later to text which is formatted.'$'\n''All decorate calls made after this call will output with special codes not to be displayed to the user.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_DECORATE'$'\n'''
