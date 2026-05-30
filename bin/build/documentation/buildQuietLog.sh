#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
# shellcheck disable=SC2034
argument=$'name - String. Required. The log file name to create. Trims leading `_` if present.\n--no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate the path for a quiet log in the build cache directory, creating it if necessary.\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildQuietLog"
fnMarker="buildquietlog"
foundNames=([0]="argument")
line="658"
rawComment=$'Generate the path for a quiet log in the build cache directory, creating it if necessary.\nArgument: name - String. Required. The log file name to create. Trims leading `_` if present.\nArgument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="16a877ce34323f71849bcba9805acd71769a633e"
sourceLine="658"
summary="Generate the path for a quiet log in the build"
summaryComputed="true"
usage="buildQuietLog name [ --no-create ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildQuietLog'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --no-create ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname         '$'\e''[[(value)]mString. Required. The log file name to create. Trims leading '$'\e''[[(code)]m_'$'\e''[[(reset)]m if present.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--no-create  '$'\e''[[(value)]mFlag. Optional. Do not require creation of the directory where the log file will appear.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate the path for a quiet log in the build cache directory, creating it if necessary.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: buildQuietLog name [ --no-create ]'$'\n'''$'\n''    name         String. Required. The log file name to create. Trims leading _ if present.'$'\n''    --no-create  Flag. Optional. Do not require creation of the directory where the log file will appear.'$'\n'''$'\n''Generate the path for a quiet log in the build cache directory, creating it if necessary.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/build.md"
