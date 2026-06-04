#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs a line and fills the remainder with space"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="plasterLines"
fnMarker="plasterlines"
foundNames=()
line="265"
rawComment="Outputs a line and fills the remainder with space"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="07796ffc2b7321ebd8b87945b7b797d05510cb69"
sourceLine="265"
summary="Outputs a line and fills the remainder with space"
summaryComputed="true"
usage="plasterLines"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mplasterLines'$'\e''[0m'$'\n'''$'\n''Outputs a line and fills the remainder with space'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: plasterLines'$'\n'''$'\n''Outputs a line and fills the remainder with space'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/cursor.md"
