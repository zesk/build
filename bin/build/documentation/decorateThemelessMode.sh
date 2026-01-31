#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="theme.sh"
description="Converts decoration style to a mode where the theme can be applied later to text which is formatted."$'\n'"All decorate calls made after this call will output with special codes not to be displayed to the user."$'\n'"Argument: --end - Flag. Optional. End themeless mode."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: __BUILD_DECORATE"$'\n'""
file="bin/build/tools/decorate/theme.sh"
foundNames=()
rawComment="Converts decoration style to a mode where the theme can be applied later to text which is formatted."$'\n'"All decorate calls made after this call will output with special codes not to be displayed to the user."$'\n'"Argument: --end - Flag. Optional. End themeless mode."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: __BUILD_DECORATE"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/theme.sh"
sourceHash="cec9c147aea52bbb59ceaa1d4c8db65022cf93bc"
summary="Converts decoration style to a mode where the theme can"
usage="decorateThemelessMode"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateThemelessMode'$'\e''[0m'$'\n'''$'\n''Converts decoration style to a mode where the theme can be applied later to text which is formatted.'$'\n''All decorate calls made after this call will output with special codes not to be displayed to the user.'$'\n''Argument: --end - Flag. Optional. End themeless mode.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Environment: __BUILD_DECORATE'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorateThemelessMode'$'\n'''$'\n''Converts decoration style to a mode where the theme can be applied later to text which is formatted.'$'\n''All decorate calls made after this call will output with special codes not to be displayed to the user.'$'\n''Argument: --end - Flag. Optional. End themeless mode.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Environment: __BUILD_DECORATE'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.493
