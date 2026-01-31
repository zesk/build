#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="name - String. Required. The log file name to create. Trims leading \`_\` if present."$'\n'"--no-create - Flag. Optional. Do not require creation of the directory where the log file will appear."$'\n'""
base="build.sh"
description="Generate the path for a quiet log in the build cache directory, creating it if necessary."$'\n'""
file="bin/build/tools/build.sh"
foundNames=([0]="argument")
rawComment="Generate the path for a quiet log in the build cache directory, creating it if necessary."$'\n'"Argument: name - String. Required. The log file name to create. Trims leading \`_\` if present."$'\n'"Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Generate the path for a quiet log in the build"
summaryComputed="true"
usage="buildQuietLog name [ --no-create ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildQuietLog'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --no-create ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname         '$'\e''[[(value)]mString. Required. The log file name to create. Trims leading '$'\e''[[(code)]m_'$'\e''[[(reset)]m if present.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--no-create  '$'\e''[[(value)]mFlag. Optional. Do not require creation of the directory where the log file will appear.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate the path for a quiet log in the build cache directory, creating it if necessary.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbuildQuietLog [[(bold)]m[[(magenta)]mname [[(blue)]m[ --no-create ]'$'\n'''$'\n''    [[(red)]mname         [[(value)]mString. Required. The log file name to create. Trims leading [[(code)]m_[[(reset)]m if present.[[(reset)]m'$'\n''    [[(blue)]m--no-create  [[(value)]mFlag. Optional. Do not require creation of the directory where the log file will appear.[[(reset)]m'$'\n'''$'\n''Generate the path for a quiet log in the build cache directory, creating it if necessary.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
