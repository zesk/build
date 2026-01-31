#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="style.sh"
description="Fetch"$'\n'"Argument: style - String. Required. The style to fetch or replace."$'\n'"Argument: newFormat - String. Optional. The new style formatting options as a string in the form \`lp dp label\`"$'\n'""
file="bin/build/tools/decorate/style.sh"
foundNames=()
rawComment="Fetch"$'\n'"Argument: style - String. Required. The style to fetch or replace."$'\n'"Argument: newFormat - String. Optional. The new style formatting options as a string in the form \`lp dp label\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/style.sh"
sourceHash="601bbde7ce12bd46ccd1228785f4e2d81a3f52c1"
summary="Fetch"
usage="decorateStyle"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateStyle'$'\e''[0m'$'\n'''$'\n''Fetch'$'\n''Argument: style - String. Required. The style to fetch or replace.'$'\n''Argument: newFormat - String. Optional. The new style formatting options as a string in the form '$'\e''[[(code)]mlp dp label'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorateStyle'$'\n'''$'\n''Fetch'$'\n''Argument: style - String. Required. The style to fetch or replace.'$'\n''Argument: newFormat - String. Optional. The new style formatting options as a string in the form lp dp label'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.434
