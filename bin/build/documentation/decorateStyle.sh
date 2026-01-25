#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate/style.sh"
argument="style - String. Required. The style to fetch or replace."$'\n'"newFormat - String. Optional. The new style formatting options as a string in the form \`lp dp label\`"$'\n'""
base="style.sh"
description="Fetch"$'\n'""
exitCode="0"
file="bin/build/tools/decorate/style.sh"
foundNames=([0]="argument")
rawComment="Fetch"$'\n'"Argument: style - String. Required. The style to fetch or replace."$'\n'"Argument: newFormat - String. Optional. The new style formatting options as a string in the form \`lp dp label\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769205647"
summary="Fetch"
usage="decorateStyle style [ newFormat ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdecorateStyle'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mstyle'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ newFormat ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mstyle      '$'\e''[[value]mString. Required. The style to fetch or replace.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mnewFormat  '$'\e''[[value]mString. Optional. The new style formatting options as a string in the form '$'\e''[[code]mlp dp label'$'\e''[[reset]m'$'\e''[[reset]m'$'\n'''$'\n''Fetch'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorateStyle style [ newFormat ]'$'\n'''$'\n''    style      String. Required. The style to fetch or replace.'$'\n''    newFormat  String. Optional. The new style formatting options as a string in the form lp dp label'$'\n'''$'\n''Fetch'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
