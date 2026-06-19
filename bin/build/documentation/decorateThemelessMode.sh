#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--end - Flag. Optional. End themeless mode.\n--help - Flag. Optional. Display this help.\n'
base="theme.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Converts decoration style to a mode where the theme can be applied later to text which is formatted.\nAll decorate calls made after this call will output with special codes not to be displayed to the user.\n\n'
descriptionLineCount="3"
environment=$'__BUILD_DECORATE\n'
file="bin/build/tools/decorate/theme.sh"
fn="decorateThemelessMode"
fnMarker="decoratethemelessmode"
foundNames=([0]="argument" [1]="environment" [2]="see")
line="13"
rawComment=$'Converts decoration style to a mode where the theme can be applied later to text which is formatted.\nAll decorate calls made after this call will output with special codes not to be displayed to the user.\nArgument: --end - Flag. Optional. End themeless mode.\nArgument: --help - Flag. Optional. Display this help.\nEnvironment: __BUILD_DECORATE\nSee: decorateThemed\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'decorateThemed\n'
sourceFile="bin/build/tools/decorate/theme.sh"
sourceHash="96feb31ea27d0e4e970f41f92f9cab4a46cf27d0"
sourceLine="13"
summary="Converts decoration style to a mode where the theme can"
summaryComputed="true"
usage="decorateThemelessMode [ --end ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateThemelessMode'$'\e''[0m '$'\e''[[(blue)]m[ --end ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--end   '$'\e''[[(value)]mFlag. Optional. End themeless mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts decoration style to a mode where the theme can be applied later to text which is formatted.'$'\n''All decorate calls made after this call will output with special codes not to be displayed to the user.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_DECORATE'
# shellcheck disable=SC2016
helpPlain='Usage: decorateThemelessMode [ --end ] [ --help ]'$'\n'''$'\n''    --end   Flag. Optional. End themeless mode.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Converts decoration style to a mode where the theme can be applied later to text which is formatted.'$'\n''All decorate calls made after this call will output with special codes not to be displayed to the user.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_DECORATE'
documentationPath="documentation/source/tools/decoration.md"
